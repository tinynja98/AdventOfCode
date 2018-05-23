local tempwd = debug.getinfo(1).source:sub(2):match('.*/') or ''
tempwd = tempwd..'/'

require(tempwd..'modules/utils')
fs = require(tempwd..'modules/filesystem')

rootpath,tempwd = fs.getscriptdir(debug.getinfo(1).source),nil

local function parseError(msg)
	if msg:match("reload") then
		return "reload"
	elseif not msg:match("exit") then
		print(msg)
	end
end

local function parseError(msg)
	if msg:match("exit") or msg:match("interrupted!") then
		return true
	elseif not msg:match("reload") then
		print(msg)
	end
	io.write("\n")
	return false
end

--------------------------------

function checkYearAvailability(y,out)
	if io.popen("if exist \""..rootpath..y.."\" echo true"):read("*l") then
		local dayList = {}
		for l in io.popen("dir \""..rootpath..y.."\" /b /ad"):lines() do
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
	if io.popen("if exist \""..rootpath..y.."/Day "..d.."/day"..d..".lua\" echo true"):read("*l") then
		return true
	end
	if out then
		io.write("Day "..d.." ("..y..") has no solution yet.\n\n")
		sleep(0.5)
	end
	return false
end

function testEnvironment(...)
	local input = {...}
	repeat
		io.write("--------Tests--------\n")
		xpcall(loadfile(rootpath.."modules/tests.lua"),parseError,table.unpack(input))
		io.write("---------End---------\n")
		io.write('Test input (or "exit"): ')
		input = io.read()
		if input ~= '' then
			input = string.cut(input," ")
		else
			input = {}
		end
	until input[1] == "exit"
end

------------CODE------------

local args = arg

while not exit do
	local yearList,dayList,input,year,day,skip = {},{},nil,false,false,false
	if args[1] ~= nil and args[1]:gsub("test[s]?","") == "" then
		arg = table.shift({table.unpack(arg,-1,0)},-2)
		testEnvironment(table.unpack(args,2))
		args = {}
	end
	if args[1] == nil or not checkYearAvailability(args[1],true) then
		repeat
			io.write("What year's puzzles are we solving? ")
			input = string.cut(io.read()," ")
			if input[1] == "exit" then
				exit,skip = true,true
			elseif input[1]:match("test[s]?") then
				testEnvironment(table.unpack(input,2))
			elseif tonumber(input[1]) ~= nil and checkYearAvailability(input[1],true) then
				year = input[1]
				table.remove(input,1)
			end
		until year or skip
	else
		year = args[1]
		input = {table.unpack(args,2)}
	end
	if not skip and (input[1] == nil or tonumber(input[1]) == nil or not checkDayAvailability(year,input[1],true)) then
		repeat
			io.write("What day ("..year..") do you want to solve? ")
			input = string.cut(io.read()," ")
			if input[1] == "exit" then
				exit,skip = true,true
			elseif input[1] == "back" then
				skip = true
			elseif input[1]:match("test[s]?") then
				testEnvironment()
			elseif tonumber(input[1]) ~= nil and checkDayAvailability(year,input[1],true) then
				day = input[1]
			end
		until day or skip
	else
		day = input[1]
	end
	if not skip then
		io.write("\n")
		local result = select(2,xpcall(loadfile(rootpath..year.."/Day "..day.."/day"..day..".lua"),parseError,table.unpack(input)))
		io.write("\n")
	end
end