local pwd = fs.getscriptdir(debug.getinfo(1).source)
local file = io.open(pwd.."input.txt")
local xpos,ypos = 0,0
local xmovements = {n = 0,ne = 1,se = 1,s = 0,sw = -1,nw = -1}
local ymovements = {n = 1,ne = 0.5,se = -0.5,s = -1,sw = -0.5,nw = 0.5}

local function getmoves(x,y)
	local moves = 0
	if x > math.abs(y*2) then
		moves = x
	else
		moves = math.abs(y)-math.abs(x) --Originally math.abs(x)+(math.abs(y)-2*math.abs(x))
	end
	return moves
end

local input,part2 = file:read('a'):cut(','),0
file:close()

for i = 1,#input do
	xpos = xpos+xmovements[input[i]]
	ypos = ypos+ymovements[input[i]]
	local temppart2 = getmoves(xpos,ypos)
	if temppart2 > part2 then
		part2 = temppart2
	end
end

part1 = getmoves(xpos,ypos)

print('Part 1: '..part1)
print('Part 2: '..part2)