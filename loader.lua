local args,pwd = {...},""

local function cut(s,pattern,remove,i)
	local i2 = 0
	if remove == nil then remove = true end
  if pattern == nil then pattern = " " end
	if tonumber(i) ~= nil then i2 = i-1 end
	local cutstring = {}
	repeat
		local i1 = i2
    i2 = s:find(pattern,i1+1)
		if i2 == nil then i2 = s:len()+1 end
		if remove then
			table.insert(cutstring,s:sub(i1+1,i2-1))
		else
			table.insert(cutstring,s:sub(i1,i2-1))
		end
	until i2 == s:len()+1
  return cutstring
end

local function parseError(msg)
	if msg:match("reload") then
		return "reload"
	elseif not msg:match("exit") then
		print(msg)
	end
end

local pwd1 = (io.popen("echo %cd%"):read("*l")):gsub("\\","/")
local pwd2 = debug.getinfo(1).source:sub(2):gsub("\\","/")

if pwd2:sub(2,3) == ":/" then
	pwd = pwd2:sub(1,pwd2:find("[^/]*%.lua")-1)
else
	local path1 = cut(pwd1:sub(4),"/")
	local path2 = cut(pwd2,"/")
	for i = 1,#path2-1 do
		if path2[i] == ".." then
			table.remove(path1)
		else
			table.insert(path1,path2[i])
		end
	end
	pwd = pwd1:sub(1,3)
	for i = 1,#path1 do
		pwd = pwd..path1[i].."/"
	end
end

cut = nil

dofile(pwd.."utils.lua")

----------CODE----------

repeat
  local yearList,dayList,inputs,read,year,exit = {},{},{},"","",false
  if args[1] == nil then
    repeat
      io.write("What year's puzzles are we solving? ")
      read = io.read()
      inputs = string.cut(read)
      if tonumber(inputs[1]) ~= nil then
        for dirName in io.popen("dir \""..pwd.."\" /B /AD"):lines() do
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
			inputs = string.cut(read)
			if inputs[1] == "exit" then
				error("exit")
			elseif inputs[1] == "reload" then
				error("reload")
			end
    until tonumber(inputs[1]) ~= nil or exit
	end
	if not exit then
		for dirName in io.popen("dir \""..pwd..year.."\" /B /AD"):lines() do
			if string.match(dirName,"Day [0-9]+") then
				table.insert(dayList,dirName)
			end
		end
    local dayFolder = "Day "..inputs[1]
    if table.find(dayList,dayFolder) and io.popen("if exist \""..pwd..year.."/"..dayFolder.."/day"..inputs[1]..".lua\" echo true"):read("*l") then
			io.write("\n")
			local dump,result = xpcall(loadfile(pwd..year.."/"..dayFolder.."/day"..inputs[1]..".lua"),parseError,table.unpack(inputs,2))
			if result == "reload" then error("reload") end
    else
      print("That day has not yet been solved.")
    end
    io.write("\n")
  end
until exit