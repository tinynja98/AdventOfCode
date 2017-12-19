if getScriptDir == nil then error("loader.lua can't be run alone. Please execute main.lua") end
if loader then io.write("Reloaded loader.lua.\n") end
loader = true

local function parseError(msg)
	if msg:match("reload") then
		return "reload"
	elseif not msg:match("exit") then
		print(msg)
	end
end

function checkYearAvailability(y,out)
	if io.popen("if exist \""..rootPath..y.."\" echo true"):read("*l") then
		local dayList = {}
		for l in io.popen("dir \""..rootPath..y.."\" /b /ad"):lines() do
			if l:gsub("Day %d+","") == "" then
				table.insert(dayList,l:match("%d+"))
			end
		end
		for i = 1,#dayList do
			if checkDayAvailability(y,dayList[i]) then
				return true
			end
		end
	end
	if out then
		io.write("Year "..y.." has no solution yet.\n\n")
		sleep(0.5)
	end
	return false
end

function checkDayAvailability(y,d,out)
	if io.popen("if exist \""..rootPath..y.."/Day "..d.."/day"..d..".lua\" echo true"):read("*l") then
		return true
	end
	if out then
		io.write("Day "..d.." ("..y..") has no solution yet.\n\n")
		sleep(0.5)
	end
	return false
end

------------CODE------------
local args,pwd = {...},getScriptDir(debug.getinfo(1).source)

while not exit do
	local yearList,dayList,input,year,day,exit = {},{},false,false,false
	if args[1] == nil or not checkYearAvailability(args[1],true) then
		repeat
			io.write("What year's puzzles are we solving? ")
			input = string.cut(io.read()," ")
			if input[1] == "exit" then
				error("exit")
			elseif input[1] == "reload" then
				error("reload")
			elseif tonumber(input[1]) ~= nil and checkYearAvailability(input[1],true) then
				year = input[1]
				table.remove(input,1)
			end
		until year
	else
		year = args[1]
		input = {table.unpack(args,2)}
	end
	if input[1] == nil or tonumber(input[1]) == nil or not checkDayAvailability(year,input[1],true) then
		repeat
			io.write("What day ("..year..") do you want to solve? ")
			input = string.cut(io.read()," ")
			if input[1] == "exit" then
				error("exit")
			elseif input[1] == "reload" then
				error("reload")
			elseif tonumber(input[1]) ~= nil and checkDayAvailability(year,input[1],true) then
				day = input[1]
			end
		until day
	else
		day = input[1]
	end
	table.remove(input,1)
	io.write("\n")
	local result = select(2,xpcall(loadfile(rootPath..year.."/Day "..day.."/day"..day..".lua"),parseError,table.unpack(input)))
	if result == "reload" then error("reload") end
	io.write("\n")
end