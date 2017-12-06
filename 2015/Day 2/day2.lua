local pwd = getScriptDir(debug.getinfo(1).source)
local file,input,surface,ribbon = io.open(pwd.."input.txt"),"",0,0

if file then
	local i = 0
	for l in file:lines() do
		i = i+1
		if not l:match("%d+x%d+x%d") then
			print("Invalid format detected in \"input.txt\" on line "..i.." (\""..l.."\")")
			file:close()
			break
		end
	end
	file:seek("set")
	input = file:read("*a")
	file:close()
end

if arg[1] and arg[1]:match("%d+x%d+x%d") then
	input = arg[1]
elseif input == "" then
	repeat
		io.write("Input: ")
		input = io.read()
	until input:match("%d+x%d+x%d")
end

local lines = string.cut(input,"\n")
for i1 = 1,#lines do
	-- Parts 1 & 2
	local sides = string.cut(lines[i1],"x")
	local slack,perimeter,volume = math.huge,math.huge,1
	for i2 = 1,#sides do
		surface = surface+2*sides[i2]*sides[i2%3+1]
		slack = math.min(slack,sides[i2]*sides[i2%3+1])
		perimeter = math.min(perimeter,2*sides[i2]+2*sides[i2%3+1])
		volume = volume*sides[i2]
	end
	surface = surface+slack
	ribbon = ribbon+perimeter+volume
end

print("Part 1: "..math.floor(surface).." ft^2")
print("Part 2: "..math.floor(ribbon).." ft")