local pwd = getScriptDir()

function resolve(number,jump)
  local result = 0
  for i = 1,string.len(number) do
    local next = (i-1+jump)%string.len(number)+1
    if tonumber(string.sub(number,i,i)) == tonumber(string.sub(number,next,next)) then
      result = result+tonumber(string.sub(number,i,i))
    end
  end
  return result
end

local args,input = {...},0
if tonumber(args[1]) ~= nil  then
  input = args[1]
elseif tonumber(io.open(pwd.."Day 1/Input.txt"):read("*a")) ~= nil then
  if args[1] ~= nil then
    print("\""..args[1].."\" is not a number. Using number in \"Input.txt\".")
  end
  input = io.open(pwd.."Day 1/Input.txt"):read("*a")
else
  print("Invalid number in \"Input.txt\".")
  repeat
    io.write("Input: ")
    input = tonumber(io.read())
  until input ~= nil and input >= 1
end

print("Part1: "..resolve(input,1))
print("Part2: "..resolve(input,tonumber(string.len(input)/2)))