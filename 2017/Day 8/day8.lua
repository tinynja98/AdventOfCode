local pwd = fs.getscriptdir(debug.getinfo(1).source)
local file,reg,part1,part2 = io.open(pwd.."input.txt"),{},-math.huge,-math.huge

for line in file:lines() do
	--Example: hwv inc 149 if clj >= -5
	local inst = string.cut(line,' ')
	if reg[inst[1]] == nil then reg[inst[1]] = 0 end
	if reg[inst[5]] == nil then reg[inst[5]] = 0 end
	if inst[2] == 'inc' then
		operation = 1
	else
		operation = -1
	end
	if inst[6] == '<' and reg[inst[5]] < tonumber(inst[7]) then
		reg[inst[1]] = reg[inst[1]]+operation*tonumber(inst[3])
	elseif inst[6] == '>' and reg[inst[5]] > tonumber(inst[7]) then
		reg[inst[1]] = reg[inst[1]]+operation*tonumber(inst[3])
	elseif inst[6] == '<=' and reg[inst[5]] <= tonumber(inst[7]) then
		reg[inst[1]] = reg[inst[1]]+operation*tonumber(inst[3])
	elseif inst[6] == '>=' and reg[inst[5]] >= tonumber(inst[7]) then
		reg[inst[1]] = reg[inst[1]]+operation*tonumber(inst[3])
	elseif inst[6] == '==' and reg[inst[5]] == tonumber(inst[7]) then
		reg[inst[1]] = reg[inst[1]]+operation*tonumber(inst[3])
	elseif inst[6] == '!=' and reg[inst[5]] ~= tonumber(inst[7]) then
		reg[inst[1]] = reg[inst[1]]+operation*tonumber(inst[3])
	end
	if reg[inst[1]] > part2 then part2 = reg[inst[1]] end
end

file:close()

for k,v in pairs(reg) do
	if v > part1 then
		part1 = v
	end
end

print('Part 1: '..part1)
print('Part 2: '..part2)