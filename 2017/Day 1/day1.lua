local pwd = getScriptDir(debug.getinfo(1).source)

function resolve(number,jump)
	local result = 0
	if jump%1 ~= 0 then return "bad argument #2 to 'resolve' (jump must be an integer)" end
  for i = 1,string.len(number) do
    local next = (i-1+jump)%string.len(number)+1
    if tonumber(string.sub(number,i,i)) == tonumber(string.sub(number,next,next)) then
      result = result+tonumber(string.sub(number,i,i))
    end
  end
  return result
end

local input = 0
if tonumber(arg[1]) ~= nil  then
  input = arg[1]
elseif tonumber(io.open(pwd.."input.txt"):read("*a")) ~= nil then
  if arg[1] ~= nil then
    print("\""..arg[1].."\" is not a number. Using number in \"Input.txt\".")
  end
  input = io.open(pwd.."input.txt"):read("*a")
else
  print("Invalid number in \"Input.txt\".")
  repeat
    io.write("Input: ")
    input = tonumber(io.read())
  until input ~= nil and input >= 1
end

print("Part1: "..resolve(input,1))
print("Part2: "..resolve(input,tonumber(string.len(input)/2)))