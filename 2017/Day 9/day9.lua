local pwd = fs.getscriptdir(debug.getinfo(1).source)
local file = io.open(pwd.."input.txt")

local input = file:read('a')
file:close()

--Example: {{<ab>},{<ab>},{<ab>},{<ab>}}
local part1,part2,level,garbage,skip = 0,0,1,false,false
for i = 1,input:len() do
	local char = input:sub(i,i)
	if skip then
		skip = false
	elseif garbage then
		if char == '!' then
			skip = true
		elseif char == '>' then
			garbage = false
		else
			part2 = part2+1
		end
	elseif char == '<' then
		garbage = true
	elseif char == '{' then
		part1 = part1+level
		level = level+1
	elseif char == '}' then
		level = level-1
	end
end

print('Part 1: '..part1)
print('Part 2: '..part2)