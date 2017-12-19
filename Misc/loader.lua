if loader then io.write("Reloaded loader.lua.\n") end
loader = true

local function parseError(msg)
	if msg:match("reload") then
		return "reload"
	elseif not msg:match("exit") then
		print(msg)
	end
end

------------CODE------------
local args,pwd = {...},getScriptDir(debug.getinfo(1).source)

repeat
  local yearList,dayList,inputs,read,year,exit = {},{},{},"","",false
  if args[1] == nil then
    repeat
      io.write("What year's puzzles are we solving? ")
      read = io.read()
      inputs = string.cut(read," ")
      if tonumber(inputs[1]) ~= nil then
        for dirName in io.popen("dir \""..rootPath.."\" /B /AD"):lines() do
          if dirName:match("[0-9]+") then
            table.insert(yearList,dirName)
          end
        end
			end
			if inputs[1] == "exit" then
				error("exit")
			elseif inputs[1] == "reload" then
				error("reload")
			elseif not table.find(yearList,inputs[1]) then
				io.write("That year has not yet been solved.\n\n")
			end
    until (tonumber(inputs[1]) ~= nil and table.find(yearList,inputs[1])) or exit
    year = inputs[1]
    table.remove(inputs,1)
  else
    year = args[1]
  end
  if (inputs[1] == nil or tonumber(inputs[1]) == nil) and not exit then
    repeat
      io.write("What day do you want to solve? ")
      read = io.read()
			inputs = string.cut(read," ")
			if inputs[1] == "exit" then
				error("exit")
			elseif inputs[1] == "reload" then
				error("reload")
			end
    until tonumber(inputs[1]) ~= nil or exit
	end
	if not exit then
		for dirName in io.popen("dir \""..rootPath..year.."\" /B /AD"):lines() do
			if string.match(dirName,"Day [0-9]+") then
				table.insert(dayList,dirName)
			end
		end
    local dayFolder = "Day "..inputs[1]
    if table.find(dayList,dayFolder) and io.popen("if exist \""..rootPath..year.."/"..dayFolder.."/day"..inputs[1]..".lua\" echo true"):read("*l") then
			io.write("\n")
			local dump,result = xpcall(loadfile(rootPath..year.."/"..dayFolder.."/day"..inputs[1]..".lua"),parseError,table.unpack(inputs,2))
			if result == "reload" then error("reload") end
    else
      print("That day has not yet been solved.")
    end
    io.write("\n")
  end
until exit