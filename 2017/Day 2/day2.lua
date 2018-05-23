local pwd = fs.getscriptdir(debug.getinfo(1).source)

local input = io.open(pwd.."input.txt"):read("*a")
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
print("Part2: "..math.floor(result2))