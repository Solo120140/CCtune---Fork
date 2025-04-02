local downloader = {}

---Encode a string into HTML
---@param str string
---@return string str HTML encoded string
local function urlEncode(str)
  -- Convert the input string into its percent-encoded equivalent
  if str then
    str = string.gsub(str, "([^%w%-%.%_%~])", function(c)
      return string.format("%%%02X", string.byte(c))
    end)
  end
  return str
end

--- Creates a direct download link based on a public Nextcloud folder share link
--- @param baseUrl string The folder URL
--- @param fileName string The file to be  retrieved
--- @return string url The direct download link
--- @throws If the generated download link cannot be requested
function downloader:getNextcloudUrl(baseUrl, fileName)
  assert(baseUrl ~= nil, "baseUrl cannot be nil!")
  assert(fileName ~= nil, "fileName cannot be nil!")

  local url = ""

  if string.sub(baseUrl, -1) ~= "/" then
    url = baseUrl .. "/"
  else
    url = baseUrl
  end

  url = url .. "download?path=%2F&files=" .. urlEncode(fileName)

  if not http.checkURL(url) then
    error(baseUrl .. "\nThe generated url cannot be requested!")
  end

  return url
end

--- Creates a direct download link for a raw file on GitHub
--- @param baseUrl string The base URL of the GitHub repository (e.g., "https://github.com/user/repo")
--- @param branch string The branch name (e.g., "main")
--- @param filePath string The path to the file within the repository
--- @param fileName string The name of the file
--- @return string The raw GitHub URL
function downloader:getGitHubRawUrl(baseUrl, branch, filePath, fileName)
  assert(baseUrl ~= nil, "baseUrl cannot be nil!")
  assert(branch ~= nil, "branch cannot be nil!")
  assert(filePath ~= nil, "filePath cannot be nil!")
  assert(fileName ~= nil, "fileName cannot be nil!")

  local rawUrl = baseUrl:gsub("github.com", "raw.githubusercontent.com") .. "/" .. branch .. "/" .. filePath .. "/" .. fileName

  if not http.checkURL(rawUrl) then
    error(baseUrl .. "/" .. branch .. "/" .. filePath .. "/" .. fileName .. "\nThe generated GitHub URL cannot be requested!")
  end

  return rawUrl
end

return downloader
