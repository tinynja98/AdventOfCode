function getParameters(n)
  local d = math.ceil(math.sqrt(n)) -- not necesserly the correct diameter
  if (d)%2 == 0 then
    d = d+1
  end
  local pic,dfs,man = 0,0,1 -- pic: position in circumference, dfs: distance from straight line, man: manhattan distance
  if d > 1 then
    pic = n-((d-2)^2+1)
    dfs = math.abs(math.ceil(d/2)-(pic%(d-1)+2))
    man = math.floor(d/2)+dfs
  end
  return d, pic, dfs, man
end

local input = 0
repeat
  io.write("Square that needs to be accessed: ")
  input = tonumber(io.read()) -- default: 312051
until input ~= nil and input >= 1

----------Part 1----------
local dump,dump,dump,manhattan = getParameters(input)
print("Part 1: "..manhattan.." steps",dump)

----------Part 2----------
local memory = {x0={y0={1}}}
local i,x,y = 1,0,0
repeat
  i = i+1
  local diameter,posInCir,disFromStraight = getDiameter(i)
  local side = math.floor(posInCir/(diameter-1))
  if side%2 == 0 then
    x = math.floor(diameter/2)
    y = 
until > input