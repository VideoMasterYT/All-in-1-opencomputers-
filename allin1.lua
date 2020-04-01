local gpu=assert(component.list("gpu",true)(),"No gpu found")
if not component.invoke(gpu,"getScreen") then assert(component.invoke(gpu,"bind",component.list("screen",true)())) end

local fs
for ad in component.list("filesystem",true) do
  if not component.invoke(ad,"isReadOnly") and not component.invoke(ad,"getLabel") then fs=ad break end
end
assert(fs,"Insert writeable filesystem")

local pc = component.list("computer",true)()
local net = assert(component.list("internet",true)(),"Insert internet card")

local c=1

local source={
    {"Dkiller1","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"},
    {"Dkiller2","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"},
    {"Dkiller3","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"},
    {"Dkiller4","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"},
    {"Dkiller5","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"},
    {"Dkiller6","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"},
    {"Dkiller7","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"},
    {"Dkiller8","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"},
    {"Dkiller9","https://www.dropbox.com/s/brd4x7is4kbxg4u/writer.lua?dl=1"}
}

local function tfind(fsize)
    if fsize>=1048567 then
        return "hard drive"
    else 
        return "floppy drive"
    end
end

component.invoke(gpu,"setForeground",0xffffff)

local mlen=0
for _,v in ipairs(source) do
mlen=math.max(#v[1],mlen)
end

local x,y=component.invoke(gpu,"maxResolution")
component.invoke(gpu,"fill",1,1,x,y," ")
component.invoke(gpu,"set",1,1,"Choose programm to install:")
for k,v in ipairs(source) do
component.invoke(gpu,"set",1,k+1,v[1])
end
component.invoke(gpu,"set",mlen+1,c+1,"<")

while true do
local ps
repeat
ps=table.pack(computer.pullSignal(1))
until ps[1]=="key_up" and (ps[4]==200 or ps[4]==208 or ps[4]==205)

if ps[4]==200 then c=(c-2+(#source))%(#source)+1
elseif ps[4]==208 then c=(c)%#source+1
elseif ps[4]==205 then break end
component.invoke(gpu,"fill",mlen+1,2,1,#source," ")
component.invoke(gpu,"set",mlen+1,c+1,"<")
end

fssize=component.invoke(fs,"spaceTotal")
local ftp=tfind(fssize)

local Hnet = component.invoke(net,"request",source[c][2])
local Hfs = assert(component.invoke(fs,"open","/init.lua","w"),"Can't open descryptor")

component.invoke(gpu,"fill",1,1,x,y," ")
component.invoke(gpu,"set",1,1,"Downloading file:")

local t=2
for str in Hnet.read do
component.invoke(fs,"write",Hfs,str)
component.invoke(gpu,"set",1,t,str)
t=t+1
end

component.invoke(fs,"close",Hfs)
component.invoke(fs,"setLabel",source[c][1])
component.invoke(pc,"stop")
