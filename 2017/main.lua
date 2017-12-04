_loadfile = loadfile
function loadfile(file)
  return _loadfile(pwd..file)
end

_dofile = dofile
function dofile(file)
  return _dofile(pwd..file)
end

--------CODE--------
local pwdComplement = debug.getinfo(1).source:sub(2)
pwd = string.gsub(io.popen("echo %cd%"):read('*l').."\\","\\","/")..string.sub(pwdComplement,0,string.find(pwdComplement,"main.lua")-1)
print(pwd)
_dofile(string.sub(pwd,1,string.find(pwd,"2017")-1).."/utils.lua")
local dayList,args,input = {},{},""

repeat
  repeat
    io.write("What day do you want to solve? ")
    input = io.read()
    for fileName in io.popen([[dir "]]..pwd..[[" /B /AD]]):lines() do
      if string.match(fileName,"Day [0-9]+") then
        table.insert(dayList, fileName)
      end
    end
    args = string.cut(input," ")
  until tonumber(args[1]) ~= nil or args[1] == "exit"
  if args[1] ~= "exit" then
    local dayFolder = "Day "..args[1]
    if table.find(dayList,dayFolder) then
      io.write("\n")
      xpcall(loadfile(dayFolder.."/main.lua"),print,table.unpack(args,2))
    else
      print("That day has not yet been solved.")
    end
    io.write("\n")
  end
until day == "exit"