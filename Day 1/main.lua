function resolve(number,jump)
  local result = 0
  for i = 1,string.len(input) do
    local next = (i-1+jump)%string.len(input)+1
    if tonumber(string.sub(input,i,i)) == tonumber(string.sub(input,next,next)) then
      result = result+tonumber(string.sub(input,i,i))
    end
  end
  return result
end

input = io.open(pwd.."Day 1/Input.txt"):read("*a")

print("Part1: "..resolve(input,1))
print("Part2: "..resolve(input,tonumber(string.len(input)/2)))