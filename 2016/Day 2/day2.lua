local pwd = fs.getscriptdir(debug.getinfo(1).source)
local file = io.open(pwd..'input.txt')
local keypad1,part1,x1,y1 = {{1,2,3},{4,5,6},{7,8,9}},{},2,2
local keypad2,part2,x2,y2 = {{'','',1},{'',2,3,4},{5,6,7,8,9},{'','A','B','C'},{'','','D'}},{},1,3
local xmove = {U = 0,R = 1,D = 0,L = -1}
local ymove = {U = -1,R = 0,D = 1,L = 0}

for line in file:lines() do
	for i = 1,line:len() do
		-- Part 1
		if x1+xmove[line:sub(i,i)] >= 1 and x1+xmove[line:sub(i,i)] <= 3 then
			x1 = x1+xmove[line:sub(i,i)]
		end
		if y1+ymove[line:sub(i,i)] >= 1 and y1+ymove[line:sub(i,i)] <= 3 then
			y1 = y1+ymove[line:sub(i,i)]
		end
		-- Part 2
		-- Originally 3-(4-2*math.abs(x-3)/2 and 3+(4-2*math.abs(x-3)/2
		if x2+xmove[line:sub(i,i)] >= 1+math.abs(y2-3) and x2+xmove[line:sub(i,i)] <= 5-math.abs(y2-3) then
			x2 = x2+xmove[line:sub(i,i)]
		end
		if y2+ymove[line:sub(i,i)] >= 1+math.abs(x2-3) and y2+ymove[line:sub(i,i)] <= 5-math.abs(x2-3) then
			y2 = y2+ymove[line:sub(i,i)]
		end
	end
	if keypad1[y1][x1] ~= (part1[#part1] or 0) then
		table.insert(part1,keypad1[y1][x1])
	end
	if keypad2[y2][x2] ~= (part2[#part2] or 0) then
		table.insert(part2,keypad2[y2][x2])
	end
end

file:close()

part1 = table.concat(part1)
part2 = table.concat(part2)

print('Part 1: '..part1)
print('Part 1: '..part2)