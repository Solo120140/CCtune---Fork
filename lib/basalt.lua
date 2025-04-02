local aa={}local ba=true;local ca=require
local da=function(ab)
for bb,cb in pairs(aa)do
if(type(cb)=="table")then for db,_c in pairs(cb)do if(db==ab)then
return _c()end end else if(bb==ab)then return cb()end end end;return ca(ab)end
local _b=function(ab)if(ab~=nil)then return aa[ab]end;return aa end
aa["plugin"]=function(...)local ab={...}local bb={}local cb={}
local db=fs.getDir(ab[2]or"Basalt")local _c=fs.combine(db,"plugins")
if(ba)then
for bc,cc in pairs(_b("plugins"))do
table.insert(cb,bc)local dc=cc()
if(type(dc)=="table")then for _d,ad in pairs(dc)do
if(type(_d)=="string")then if(bb[_d]==nil)then
bb[_d]={}end;table.insert(bb[_d],ad)end end end end else
if(fs.exists(_c))then
for bc,cc in pairs(fs.list(_c))do local dc
if
(fs.isDir(fs.combine(_c,cc)))then table.insert(cb,fs.combine(_c,cc))
dc=da(cc.."/init")else table.insert(cb,cc)dc=da(cc:gsub(".lua",""))end
if(type(dc)=="table")then for _d,ad in pairs(dc)do
if(type(_d)=="string")then
if(bb[_d]==nil)then bb[_d]={}end;table.insert(bb[_d],ad)end end end end end end;local function ac(bc)return bb[bc]end
return
{get=ac,getAvailablePlugins=function()return cb end,addPlugin=function(bc)
if(fs.exists(bc))then
if(fs.isDir(bc))then
for cc,dc in
pairs(fs.list(bc))do table.insert(cb,dc)
if
not(fs.isDir(fs.combine(bc,dc)))then local _d=dc:gsub(".lua","")local ad=da(fs.combine(bc,_d))
if(
type(ad)=="table")then for bd,cd in pairs(ad)do
if(type(bd)=="string")then
if(bb[bd]==nil)then bb[bd]={}end;table.insert(bb[bd],cd)end end end end end else local cc=da(bc:gsub(".lua",""))
table.insert(cb,bc:match("[\\/]?([^\\/]-([^%.]+))$"))
if(type(cc)=="table")then for dc,_d in pairs(cc)do
if(type(dc)=="string")then
if(bb[dc]==nil)then bb[dc]={}end;table.insert(bb[dc],_d)end end end end end end,loadPlugins=function(bc,cc)
for dc,_d in
pairs(bc)do local ad=bb[dc]
if(ad~=nil)then
bc[dc]=function(...)local bd=_d(...)
for cd,dd in pairs(ad)do local __a=dd(bd,cc,...)
__a.__index=__a;bd=setmetatable(__a,bd)end;return bd end end end;return bc end}end
aa["main"]=function(...)local ab=da("basaltEvent")()
local bb=da("loadObjects")local cb;local db=da("plugin")local _c=da("utils")local ac=da("basaltLogs")
local bc=_c.uuid;local cc=_c.wrapText;local dc=_c.tableCount;local _d=300;local ad=0;local bd=0;local cd={}
local dd=term.current()local __a="1.7.0"
local a_a=fs.getDir(table.pack(...)[2]or"")local b_a,c_a,d_a,_aa,aaa={},{},{},{},{}local baa,caa,daa,_ba;local aba={}if not term.isColor or
not term.isColor()then
error('Basalt requires an advanced (golden) computer to run.',0)end;local bba={}
for adb,bdb in
pairs(colors)do if(type(bdb)=="number")then
bba[adb]={dd.getPaletteColor(bdb)}end end
local function cba()_ba=false;dd.clear()dd.setCursorPos(1,1)
for adb,bdb in pairs(colors)do if(type(bdb)==
"number")then
dd.setPaletteColor(bdb,colors.packRGB(table.unpack(bba[adb])))end end end
local function dba(adb)
assert(adb~="function","Schedule needs a function in order to work!")
return function(...)local bdb=coroutine.create(adb)
local cdb,ddb=coroutine.resume(bdb,...)
if(cdb)then table.insert(aaa,bdb)else aba.basaltError(ddb)end end end;aba.log=function(...)ac(...)end
local _ca=function(adb,bdb)_aa[adb]=bdb end;local aca=function(adb)return _aa[adb]end
local bca=function()return cb end;local cca=function(adb)return bca()[adb]end;local dca=function(adb,bdb,cdb)return
cca(bdb)(cdb,adb)end
local _da={getDynamicValueEventSetting=function()return
aba.dynamicValueEvents end,getMainFrame=function()return baa end,setVariable=_ca,getVariable=aca,setMainFrame=function(adb)baa=adb end,getActiveFrame=function()return
caa end,setActiveFrame=function(adb)caa=adb end,getFocusedObject=function()return daa end,setFocusedObject=function(adb)daa=adb end,getMonitorFrame=function(adb)return
d_a[adb]or monGroups[adb][1]end,setMonitorFrame=function(adb,bdb,cdb)if(
baa==bdb)then baa=nil end;if(cdb)then monGroups[adb]={bdb,sides}else
d_a[adb]=bdb end
if(bdb==nil)then monGroups[adb]=nil end end,getTerm=function()return
dd end,schedule=dba,stop=cba,debug=aba.debug,log=aba.log,getObjects=bca,getObject=cca,createObject=dca,getDirectory=function()return a_a end}
local function ada(adb)dd.clear()dd.setBackgroundColor(colors.black)
dd.setTextColor(colors.red)local bdb,cdb=dd.getSize()if(aba.logging)then ac(adb,"Error")end;local ddb=cc(
"Basalt error: "..adb,bdb)local __c=1;for a_c,b_c in pairs(ddb)do
dd.setCursorPos(1,__c)dd.write(b_c)__c=__c+1 end;dd.setCursorPos(1,
__c+1)_ba=false end
local function bda(adb,bdb,cdb,ddb,__c)
if(#aaa>0)then local a_c={}
for n=1,#aaa do
if(aaa[n]~=nil)then
if
(coroutine.status(aaa[n])=="suspended")then
local b_c,c_c=coroutine.resume(aaa[n],adb,bdb,cdb,ddb,__c)if not(b_c)then aba.basaltError(c_c)end else
table.insert(a_c,n)end end end
for n=1,#a_c do table.remove(aaa,a_c[n]- (n-1))end end end
local function cda()if(_ba==false)then return end;if(baa~=nil)then baa:render()
baa:updateTerm()end;for adb,bdb in pairs(d_a)do bdb:render()
bdb:updateTerm()end end;local dda,__b,a_b=nil,nil,nil;local b_b=nil
local function c_b(adb,bdb,cdb,ddb)dda,__b,a_b=bdb,cdb,ddb;if(b_b==nil)then
b_b=os.startTimer(_d/1000)end end
local function d_b()b_b=nil;baa:hoverHandler(__b,a_b,dda)caa=baa end;local _ab,aab,bab=nil,nil,nil;local cab=nil;local function dab()cab=nil;baa:dragHandler(_ab,aab,bab)
caa=baa end;local function _bb(adb,bdb,cdb,ddb)_ab,aab,bab=bdb,cdb,ddb
if(ad<50)then dab()else if(cab==nil)then cab=os.startTimer(
ad/1000)end end end
local abb=nil;local function bbb()abb=nil;cda()end
local function cbb(adb)if(bd<50)then cda()else if(abb==nil)then
abb=os.startTimer(bd/1000)end end end
local function dbb(adb,...)local bdb={...}if
(ab:sendEvent("basaltEventCycle",adb,...)==false)then return end
if(adb=="terminate")then aba.stop()end
if(baa~=nil)then
local cdb={mouse_click=baa.mouseHandler,mouse_up=baa.mouseUpHandler,mouse_scroll=baa.scrollHandler,mouse_drag=_bb,mouse_move=c_b}local ddb=cdb[adb]
if(ddb~=nil)then ddb(baa,...)bda(adb,...)cbb()return end end
if(adb=="monitor_touch")then
for cdb,ddb in pairs(d_a)do if
(ddb:mouseHandler(1,bdb[2],bdb[3],true,bdb[1]))then caa=ddb end end;bda(adb,...)cbb()return end
if(caa~=nil)then
local cdb={char=caa.charHandler,key=caa.keyHandler,key_up=caa.keyUpHandler}local ddb=cdb[adb]if(ddb~=nil)then if(adb=="key")then b_a[bdb[1]]=true elseif(adb=="key_up")then
b_a[bdb[1]]=false end;ddb(caa,...)bda(adb,...)
cbb()return end end
if(adb=="timer")and(bdb[1]==b_b)then d_b()elseif
(adb=="timer")and(bdb[1]==cab)then dab()elseif(adb=="timer")and(bdb[1]==abb)then bbb()else for cdb,ddb in pairs(c_a)do
ddb:eventHandler(adb,...)end
for cdb,ddb in pairs(d_a)do ddb:eventHandler(adb,...)end;bda(adb,...)cbb()end end;local _cb=false;local acb=false
local function bcb()
if not(_cb)then
for adb,bdb in pairs(cd)do
if(fs.exists(bdb))then
if(fs.isDir(bdb))then
local cdb=fs.list(bdb)
for ddb,__c in pairs(cdb)do
if not(fs.isDir(bdb.."/"..__c))then
local a_c=__c:gsub(".lua","")
if
(a_c~="example.lua")and not(a_c:find(".disabled"))then
if(bb[a_c]==nil)then
bb[a_c]=da(bdb.."."..__c:gsub(".lua",""))else error("Duplicate object name: "..a_c)end end end end else local cdb=bdb:gsub(".lua","")
if(bb[cdb]==nil)then bb[cdb]=da(cdb)else error(
"Duplicate object name: "..cdb)end end end end;_cb=true end
if not(acb)then cb=db.loadPlugins(bb,_da)local adb=db.get("basalt")
if
(adb~=nil)then for cdb,ddb in pairs(adb)do
for __c,a_c in pairs(ddb(aba))do aba[__c]=a_c;_da[__c]=a_c end end end;local bdb=db.get("basaltInternal")
if(bdb~=nil)then for cdb,ddb in pairs(bdb)do for __c,a_c in pairs(ddb(aba))do
_da[__c]=a_c end end end;acb=true end end
local function ccb(adb)bcb()
for cdb,ddb in pairs(c_a)do if(ddb:getName()==adb)then return nil end end;local bdb=cb["BaseFrame"](adb,_da)bdb:init()
bdb:load()bdb:draw()table.insert(c_a,bdb)
if(baa==nil)and(bdb:getName()~=
"basaltDebuggingFrame")then bdb:show()end;return bdb end
aba={basaltError=ada,logging=false,dynamicValueEvents=false,drawFrames=cda,log=ac,getVersion=function()return __a end,memory=function()return
math.floor(collectgarbage("count")+0.5).."KB"end,addObject=function(adb)if
(fs.exists(adb))then table.insert(cd,adb)end end,addPlugin=function(adb)
db.addPlugin(adb)end,getAvailablePlugins=function()return db.getAvailablePlugins()end,getAvailableObjects=function()
local adb={}for bdb,cdb in pairs(bb)do table.insert(adb,bdb)end;return adb end,setVariable=_ca,getVariable=aca,getObjects=bca,getObject=cca,createObject=dca,setBaseTerm=function(adb)
dd=adb end,resetPalette=function()
for adb,bdb in pairs(colors)do if(type(bdb)=="number")then end end end,setMouseMoveThrottle=function(adb)
if(_HOST:find("CraftOS%-PC"))then if(
config.get("mouse_move_throttle")~=10)then
config.set("mouse_move_throttle",10)end
if(adb<100)then _d=100 else _d=adb end;return true end;return false end,setRenderingThrottle=function(adb)if(
adb<=0)then bd=0 else abb=nil;bd=adb end end,setMouseDragThrottle=function(adb)if
(adb<=0)then ad=0 else cab=nil;ad=adb end end,autoUpdate=function(adb)_ba=adb;if(
adb==nil)then _ba=true end;local function bdb()cda()while _ba do
dbb(os.pullEventRaw())end end
while _ba do
local cdb,ddb=xpcall(bdb,debug.traceback)if not(cdb)then aba.basaltError(ddb)end end end,update=function(adb,...)
if(
adb~=nil)then local bdb={...}
local cdb,ddb=xpcall(function()dbb(adb,table.unpack(bdb))end,debug.traceback)if not(cdb)then aba.basaltError(ddb)return end end end,stop=cba,stopUpdate=cba,isKeyDown=function(adb)if(
b_a[adb]==nil)then return false end;return b_a[adb]end,getFrame=function(adb)for bdb,cdb in
pairs(c_a)do if(cdb.name==adb)then return cdb end end end,getActiveFrame=function()return
caa end,setActiveFrame=function(adb)
if(adb:getType()=="Container")then caa=adb;return true end;return false end,getMainFrame=function()return baa end,onEvent=function(...)
for adb,bdb in
pairs(table.pack(...))do if(type(bdb)=="function")then
ab:registerEvent("basaltEventCycle",bdb)end end end,schedule=dba,addFrame=ccb,createFrame=ccb,addMonitor=function(adb)
bcb()
for cdb,ddb in pairs(c_a)do if(ddb:getName()==adb)then return nil end end;local bdb=cb["MonitorFrame"](adb,_da)bdb:init()
bdb:load()bdb:draw()table.insert(d_a,bdb)return bdb end,removeFrame=function(adb)c_a[adb]=
nil end,setProjectDir=function(adb)a_a=adb end}local dcb=db.get("basalt")if(dcb~=nil)then
for adb,bdb in pairs(dcb)do for cdb,ddb in pairs(bdb(aba))do
aba[cdb]=ddb;_da[cdb]=ddb end end end
local _db=db.get("basaltInternal")if(_db~=nil)then
for adb,bdb in pairs(_db)do for cdb,ddb in pairs(bdb(aba))do _da[cdb]=ddb end end end;return aba end;aa["plugins"]={}
aa["plugins"]["advancedBackground"]=function(...)
local ab=da("xmlParser")
return
{VisualObject=function(bb)local cb=false;local db=colors.black
local _c={setBackground=function(ac,bc,cc,dc)bb.setBackground(ac,bc)
cb=cc or cb;db=dc or db;return ac end,setBackgroundSymbol=function(ac,bc,cc)cb=bc
db=cc or db;ac:updateDraw()return ac end,getBackgroundSymbol=function(ac)return cb end,getBackgroundSymbolColor=function(ac)return
db end,draw=function(ac)bb.draw(ac)
ac:addDraw("advanced-bg",function()local bc,cc=ac:getSize()
if
(cb~=false)then ac:addTextBox(1,1,bc,cc,cb:sub(1,1))if(cb~=" ")then
ac:addForegroundBox(1,1,bc,cc,db)end end end,2)end}return _c end}end
aa["plugins"]["bigfonts"]=function(...)local ab=da("tHex")
local bb={{"\32\32\32\137\156\148\158\159\148\135\135\144\159\139\32\136\157\32\159\139\32\32\143\32\32\143\32\32\32\32\32\32\32\32\147\148\150\131\148\32\32\32\151\140\148\151\140\147","\32\32\32\149\132\149\136\156\149\144\32\133\139\159\129\143\159\133\143\159\133\138\32\133\138\32\133\32\32\32\32\32\32\150\150\129\137\156\129\32\32\32\133\131\129\133\131\132","\32\32\32\130\131\32\130\131\32\32\129\32\32\32\32\130\131\32\130\131\32\32\32\32\143\143\143\32\32\32\32\32\32\130\129\32\130\135\32\32\32\32\131\32\32\131\32\131","\139\144\32\32\143\148\135\130\144\149\32\149\150\151\149\158\140\129\32\32\32\135\130\144\135\130\144\32\149\32\32\139\32\159\148\32\32\32\32\159\32\144\32\148\32\147\131\132","\159\135\129\131\143\149\143\138\144\138\32\133\130\149\149\137\155\149\159\143\144\147\130\132\32\149\32\147\130\132\131\159\129\139\151\129\148\32\32\139\131\135\133\32\144\130\151\32","\32\32\32\32\32\32\130\135\32\130\32\129\32\129\129\131\131\32\130\131\129\140\141\132\32\129\32\32\129\32\32\32\32\32\32\32\131\131\129\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\159\154\133\133\133\144\152\141\132\133\151\129\136\153\32\32\154\32\159\134\129\130\137\144\159\32\144\32\148\32\32\32\32\32\32\32\32\32\32\32\151\129","\32\32\32\32\133\32\32\32\32\145\145\132\141\140\132\151\129\144\150\146\129\32\32\32\138\144\32\32\159\133\136\131\132\131\151\129\32\144\32\131\131\129\32\144\32\151\129\32","\32\32\32\32\129\32\32\32\32\130\130\32\32\129\32\129\32\129\130\129\129\32\32\32\32\130\129\130\129\32\32\32\32\32\32\32\32\133\32\32\32\32\32\129\32\129\32\32","\150\156\148\136\149\32\134\131\148\134\131\148\159\134\149\136\140\129\152\131\32\135\131\149\150\131\148\150\131\148\32\148\32\32\148\32\32\152\129\143\143\144\130\155\32\134\131\148","\157\129\149\32\149\32\152\131\144\144\131\148\141\140\149\144\32\149\151\131\148\32\150\32\150\131\148\130\156\133\32\144\32\32\144\32\130\155\32\143\143\144\32\152\129\32\134\32","\130\131\32\131\131\129\131\131\129\130\131\32\32\32\129\130\131\32\130\131\32\32\129\32\130\131\32\130\129\32\32\129\32\32\133\32\32\32\129\32\32\32\130\32\32\32\129\32","\150\140\150\137\140\148\136\140\132\150\131\132\151\131\148\136\147\129\136\147\129\150\156\145\138\143\149\130\151\32\32\32\149\138\152\129\149\32\32\157\152\149\157\144\149\150\131\148","\149\143\142\149\32\149\149\32\149\149\32\144\149\32\149\149\32\32\149\32\32\149\32\149\149\32\149\32\149\32\144\32\149\149\130\148\149\32\32\149\32\149\149\130\149\149\32\149","\130\131\129\129\32\129\131\131\32\130\131\32\131\131\32\131\131\129\129\32\32\130\131\32\129\32\129\130\131\32\130\131\32\129\32\129\131\131\129\129\32\129\129\32\129\130\131\32","\136\140\132\150\131\148\136\140\132\153\140\129\131\151\129\149\32\149\149\32\149\149\32\149\137\152\129\137\152\129\131\156\133\149\131\32\150\32\32\130\148\32\152\137\144\32\32\32","\149\32\32\149\159\133\149\32\149\144\32\149\32\149\32\149\32\149\150\151\129\138\155\149\150\130\148\32\149\32\152\129\32\149\32\32\32\150\32\32\149\32\32\32\32\32\32\32","\129\32\32\130\129\129\129\32\129\130\131\32\32\129\32\130\131\32\32\129\32\129\32\129\129\32\129\32\129\32\131\131\129\130\131\32\32\32\129\130\131\32\32\32\32\140\140\132","\32\154\32\159\143\32\149\143\32\159\143\32\159\144\149\159\143\32\159\137\145\159\143\144\149\143\32\32\145\32\32\32\145\149\32\144\32\149\32\143\159\32\143\143\32\159\143\32","\32\32\32\152\140\149\151\32\149\149\32\145\149\130\149\157\140\133\32\149\32\154\143\149\151\32\149\32\149\32\144\32\149\149\153\32\32\149\32\149\133\149\149\32\149\149\32\149","\32\32\32\130\131\129\131\131\32\130\131\32\130\131\129\130\131\129\32\129\32\140\140\129\129\32\129\32\129\32\137\140\129\130\32\129\32\130\32\129\32\129\129\32\129\130\131\32","\144\143\32\159\144\144\144\143\32\159\143\144\159\138\32\144\32\144\144\32\144\144\32\144\144\32\144\144\32\144\143\143\144\32\150\129\32\149\32\130\150\32\134\137\134\134\131\148","\136\143\133\154\141\149\151\32\129\137\140\144\32\149\32\149\32\149\154\159\133\149\148\149\157\153\32\154\143\149\159\134\32\130\148\32\32\149\32\32\151\129\32\32\32\32\134\32","\133\32\32\32\32\133\129\32\32\131\131\32\32\130\32\130\131\129\32\129\32\130\131\129\129\32\129\140\140\129\131\131\129\32\130\129\32\129\32\130\129\32\32\32\32\32\129\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32","\32\32\32\32\145\32\159\139\32\151\131\132\155\143\132\134\135\145\32\149\32\158\140\129\130\130\32\152\147\155\157\134\32\32\144\144\32\32\32\32\32\32\152\131\155\131\131\129","\32\32\32\32\149\32\149\32\145\148\131\32\149\32\149\140\157\132\32\148\32\137\155\149\32\32\32\149\154\149\137\142\32\153\153\32\131\131\149\131\131\129\149\135\145\32\32\32","\32\32\32\32\129\32\130\135\32\131\131\129\134\131\132\32\129\32\32\129\32\131\131\32\32\32\32\130\131\129\32\32\32\32\129\129\32\32\32\32\32\32\130\131\129\32\32\32","\150\150\32\32\148\32\134\32\32\132\32\32\134\32\32\144\32\144\150\151\149\32\32\32\32\32\32\145\32\32\152\140\144\144\144\32\133\151\129\133\151\129\132\151\129\32\145\32","\130\129\32\131\151\129\141\32\32\142\32\32\32\32\32\149\32\149\130\149\149\32\143\32\32\32\32\142\132\32\154\143\133\157\153\132\151\150\148\151\158\132\151\150\148\144\130\148","\32\32\32\140\140\132\32\32\32\32\32\32\32\32\32\151\131\32\32\129\129\32\32\32\32\134\32\32\32\32\32\32\32\129\129\32\129\32\129\129\130\129\129\32\129\130\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\150\151\129\150\131\132\140\143\144\143\141\145\137\140\148\141\141\144\157\142\32\159\140\32\151\134\32\157\141\32","\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\151\151\32\154\143\132\157\140\32\157\140\32\157\140\32\157\140\32\32\149\32\32\149\32\32\149\32\32\149\32","\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\131\129\32\134\32\131\131\129\131\131\129\131\131\129\131\131\129\130\131\32\130\131\32\130\131\32\130\131\32","\151\131\148\152\137\145\155\140\144\152\142\145\153\140\132\153\137\32\154\142\144\155\159\132\150\156\148\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\136\32\151\140\132","\151\32\149\151\155\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\152\137\144\157\129\149\149\32\149\149\32\149\149\32\149\149\32\149\130\150\32\32\157\129\149\32\149","\131\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\129\32\130\131\32\133\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\159\159\144\152\140\144\156\143\32\159\141\129\153\140\132\157\141\32\130\145\32\32\147\32\136\153\32\130\146\32","\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\149\157\134\154\143\132\157\140\133\157\140\133\157\140\133\157\140\133\32\149\32\32\149\32\32\149\32\32\149\32","\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\130\131\32\134\32\130\131\129\130\131\129\130\131\129\130\131\129\32\129\32\32\129\32\32\129\32\32\129\32","\159\134\144\137\137\32\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\32\132\32\159\143\32\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\138\32\146\130\144","\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\131\147\129\138\134\149\149\32\149\149\32\149\149\32\149\149\32\149\154\143\149\32\157\129\154\143\149","\130\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\129\130\131\129\130\131\129\130\131\129\140\140\129\130\131\32\140\140\129"},{"000110000110110000110010101000000010000000100101","000000110110000000000010101000000010000000100101","000000000000000000000000000000000000000000000000","100010110100000010000110110000010100000100000110","000000110000000010110110000110000000000000110000","0000000000000000000000000
