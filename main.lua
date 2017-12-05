args = {...}

function string.cut(s,pattern)
	if pattern == nil then
		pattern = " "
	end
	local cutstring = {}
	local i1 = 0
	repeat
		i2 = nil
		local i2 = string.find(s,pattern,i1+1)
		if i2 == nil then
			i2 = string.len(s)+1
		end
		table.insert(cutstring,string.sub(s,i1+1,i2-1))
		i1 = i2
	until i2 == string.len(s)+1
	return cutstring
end

local pwd1 = (io.popen("echo %cd%"):read("*l")):gsub("\\","/")
local pwd2 = debug.getinfo(1).source:sub(2):gsub("\\","/")
local pwd = ""
if pwd2:sub(2,3) == ":/" then
	pwd = pwd2:sub(1,pwd2:find("[^/]*%.lua")-1)
else
	local path1 = string.cut(pwd1:sub(4),"/")
	local path2 = string.cut(pwd2,"/")
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
				exit = true
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
				exit = true
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
      xpcall(loadfile(pwd..year.."/"..dayFolder.."/day"..inputs[1]..".lua"),print,table.unpack(inputs,2))
    else
      print("That day has not yet been solved.")
    end
    io.write("\n")
  end
until exit