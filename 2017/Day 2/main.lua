function string.cut(s,pattern)
  local cutstring = {}
  local i1 = 0
  repeat
    i2 = nil
    local i2 = string.find(s,pattern,i1+1)
    if i2 == nil then i2 = string.len(s)+1 end
    table.insert(cutstring,string.sub(s,i1+1,i2-1))
    i1 = i2
  until i2 == string.len(s)+1
  return cutstring
end

local input = io.open(pwd.."Day 2/Input.txt"):read("*a")
local data = string.cut(input,"\n")
local result1,result2 = 0,0

local tempData = {}
for i = 1,#data do
  table.insert(tempData,string.cut(data[i],"\9")) -- \9 = Horizontal tab
end
data,tempData = tempData,nil

for i = 1,#data do
  local solve2 = true
  local max = -math.huge
  local min = math.huge
  for k1,v1 in pairs(data[i]) do
    max = math.max(max,tonumber(v1))
    min = math.min(min,tonumber(v1))
    if solve2 then
      for k2,v2 in pairs(data[i]) do
        if v2%v1 == 0 and v1 ~= v2 then
          result2 = result2+v2/v1
          solve2 = false
          break
        end
      end
    end
  end
  result1 = result1+max-min
end

print("Part1: "..result1)
print("Part2: "..result2)