local fs = require("filesystem")-- Use the built-in filesystem API
-- local downloader = require("downloader")


local function printHelp()
  print("Generate a .cctpl playlist")
  print("Usage: lua playlistGenerator.lua new_playlist.cctpl [options]")
  print("Options:")
  print("  -b, --base-url <url>    Specify the base URL for the playlist.")
  print("  -d, --directory <path>  Specify the directory containing the dfpwm files.")
  print("  -t, --type <type>       Specify the type of the playlist (e.g., nextcloud, github).")
  print("  --branch <branch>     Specify the branch (for github).")
  print("  --filepath <filepath> Specify the filepath (for github).")
  print("  -h, --help              Show this help message.")
  print("\nExample (Nextcloud):")
  print("  lua playlistGenerator.lua myplaylist.cctpl -b \"https://nextcloud.example.com/s/MySongs\" -d \"/path/to/files\" -t \"nextcloud\"")
  print("\nExample (GitHub):")
  print("  lua playlistGenerator.lua myplaylist.cctpl -b \"https://github.com/MyUser/MyRepo\" -d \"songs\" -t \"github\" --branch \"main\" --filepath \"music\"")
end

local function parseArgs()
  local args = {}
  local i = 1

  while i <= #arg do
    local key = arg[i]

    if key == "-b" or key == "--base-url" then
      i = i + 1
      if arg[i] then
        args.baseUrl = arg[i]
      else
        error("Error: Base URL not provided after " .. key)
      end
    elseif key == "-d" or key == "--directory" then
      i = i + 1
      if arg[i] then
        args.directory = arg[i]
      else
        error("Error: Directory not provided after " .. key)
      end
    elseif key == "-t" or key == "--type" then
      i = i + 1
      if arg[i] then
        args.type = arg[i]
      else
        error("Error: Type not provided after " .. key)
      end
    elseif key == "--branch" then
      i = i + 1
      if arg[i] then
        args.branch = arg[i]
      else
        error("Error: Branch not provided after " .. key)
      end
    elseif key == "--filepath" then
      i = i + 1
      if arg[i] then
        args.filePath = arg[i]
      else
        error("Error: Filepath not provided after " .. key)
      end
    elseif key == "-h" or key == "--help" then
      printHelp()
      os.exit(0)
    else
      if not args.targetFile then
        if arg[i]:match("^.+(%..+)$") ~= ".cctpl" then
          print("Wrong playlist file extension: " .. arg[i]:match("^.+(%..+)$"))
          print()
          printHelp()
          os.exit(1)
        end
        args.targetFile = arg[i]
      else
        print("Error: Unknown argument " .. key)
        print()
        printHelp()
        os.exit(1)
      end
    end

    i = i + 1
  end

  -- Validation (same as before, but with added checks)
  if not args.baseUrl then
    print("BaseUrl wasn't specified!")
    print()
    printHelp()
    os.exit(1)
  elseif not args.directory then
    print("No directory was specified!")
    print()
    printHelp()
    os.exit(1)
  elseif not args.type then
    print("A playlist type wasn't specified!")
    print()
    printHelp()
    os.exit(1)
  elseif not args.targetFile then
    print("A target playlist file wasn't specified!")
    print()
    printHelp()
    os.exit(1)
  elseif args.type == "github" and (not args.branch or not args.filePath) then
    print("Branch and filepath must be specified for GitHub!")
    print()
    printHelp()
    os.exit(1)
  end

  return args
end

local function getFiles(directory)
  local files = {}

  -- Check if the directory exists
  if not fs.isDir(directory) then  -- Use fs.isDir
    return nil, "Directory does not exist"
  end

  -- Iterate through the directory
  local dirHandle = fs.find(directory .. "/*.dfpwm") -- Use fs.find
  for name in dirHandle do
    table.insert(files, name)
  end

  return files
end

local function writePlaylist(filename, type, baseUrl, files, branch, filePath)
  local file, err = io.open(filename, "w")
  if not file then
    return nil, "Error opening file: " .. err
  end

  file:write("@type " .. type .. "\n")
  file:write("@baseUrl " .. baseUrl .. "\n")
  if type == "github" then
    file:write("@branch " .. (branch or "") .. "\n")
    file:write("@filepath " .. (filePath or "") .. "\n")
  end

  for _, fileName in ipairs(files) do
    file:write(fileName .. "\n")
  end

  file:close()
end

local function Main()
  local parsedArgs = parseArgs()
  local files, err = getFiles(parsedArgs.directory)
  if not files then
    error(err)
  end
  writePlaylist(parsedArgs.targetFile, parsedArgs.type, parsedArgs.baseUrl, files, parsedArgs.branch, parsedArgs.filePath)
end

Main()
