local pwd = getScriptDir(debug.getinfo(1).source)
local input,floor,part2,file = "",0,0,io.open(pwd.."input.txt")

if file then
	fileInput = file:read("*l")
	file:close()
end

if arg[1] ~= nil and not arg[1]:match("[^()]") then
	input = arg[1]
elseif fileInput and fileInput ~= nil and not fileInput:match("[^()]") then
	input = fileInput
else
	repeat
		io.write("Input: ")
		input = io.read()
	until not input:match("[^()]")
end

for i = 1,input:len() do
	if input:sub(i,i) == "(" then
		floor = floor+1
	elseif input:sub(i,i) == ")" then
		floor = floor-1
	end
	if floor == -1 and part2 == 0 then
		part2 = i
	end
end

local answerFormatting = {"st","nd","rd","th"}
print("Part 1: "..floor..answerFormatting[math.min(4,floor)].." floor")
print("Part 2: "..part2..answerFormatting[math.min(4,part2)].." character")