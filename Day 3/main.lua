function getParameters(n)
  local d = math.ceil(math.sqrt(n)) -- not necesserly the correct diameter
  if (d)%2 == 0 then
    d = d+1
  end
  local pic,dfs,man = 0,0,1 -- pic: position in circumference, dfs: distance from straight line, man: manhattan distance
  if d > 1 then
    pic = n-((d-2)^2+1)
    dfs = (pic%(d-1)+2)-math.ceil(d/2)
    man = math.floor(d/2)+math.abs(dfs)
  end
  return d, pic, dfs, man
end

local input = 0
repeat
  io.write("Input: ")
  input = tonumber(io.read()) -- default: 312051
until input ~= nil and input >= 1

----------Part 1----------
local dump,dump,dump,manhattan = getParameters(input)
print("Part 1: "..manhattan.." steps")

----------Part 2----------
local memory = {x0={y0=1}}
local i,x,y,sidePlusMinus = 1,0,0,{1,1,-1,-1}
--print("i","n","x","y","side") --debug
repeat
  i = i+1
  local diameter,posInCir,disFromStraight = getParameters(i)
  local side = math.floor(posInCir/(diameter-1))
  if side%2 == 0 then
    x = math.floor(diameter/2)*sidePlusMinus[side+1]+1-1 -- gets rid of -0
    y = disFromStraight*sidePlusMinus[side+1]+1-1
  else
    x = disFromStraight*sidePlusMinus[(side+2)%4+1]+1-1
    y = math.floor(diameter/2)*sidePlusMinus[side+1]+1-1
  end
  local n = 0
  for i1 = x-1,x+1 do
      for i2 = y-1,y+1 do
          if memory["x"..i1] ~= nil and memory["x"..i1]["y"..i2] ~= nil then
            n = n+memory["x"..i1]["y"..i2]
            --print("add",memory["x"..i1]["y"..i2],i1,i2) --debug
          end
      end
  end
  if memory["x"..x] == nil then
      memory["x"..x] = {}
  end
  memory["x"..x]["y"..y] = n
  --print(i,n,x,y,side) --debug
until memory["x"..x]["y"..y] > input
print("Part 2: "..memory["x"..x]["y"..y])