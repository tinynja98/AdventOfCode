local pwd = getScriptDir(debug.getinfo(1).source)
local file,args,argument,input = io.open(pwd.."input.txt"),{...},"",""
local x1,y1,x2,y2,locations,solved2 = 0,0,0,0,{},false
local orientationX,orientationY,orientation = {0,1,0,-1},{1,0,-1,0},1 --north,east,south,west

locations["0,0"] = 1

function validateInstructions(s)
	local inst = string.cut(s:gsub(" ",""),",")
	for i = 1,#inst do
		if not inst[i]:match("[RL]%d+") then
			return false
		end
	end
	return true
end

if args[1] then
	for i = 1,#args do
		argument = argument..args[i]..","
	end
	argument = argument:sub(1,argument:len()-1)
end

if file and file:read("*l") ~= nil then
	file:seek("set")
	local line = file:read("*l")
	if validateInstructions(line) then
		input = line
	end
	file:close()
end

if argument and validateInstructions(argument) then
	input = argument
elseif input == "" then
	repeat
		io.write("Input: ")
		input = io.read()
	until validateInstructions(input)
end

input = string.cut(input:gsub(" ",""),",")
for i1 = 1,#input do
	if input[i1]:sub(1,1) == "R" then
		orientation = orientation%4+1
	else
		orientation = (orientation-2)%4+1
	end
	for i2 = 1,tonumber(input[i1]:sub(2)) do
		x1 = x1+orientationX[orientation]
		y1 = y1+orientationY[orientation]
		if locations[x1..","..y1] == 1 and not solved2 then
			x2,y2 = x1,y1
			solved2 = true
		end
		locations[x1..","..y1] = 1
	end
end

print("Part 1: "..math.floor(math.abs(x1)+math.abs(y1)).." blocks away")
print("Part 1: "..math.floor(math.abs(x2)+math.abs(y2)).." blocks away")