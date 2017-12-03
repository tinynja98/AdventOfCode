_require = require
function require(f)
  require(pwd..f..".lua")
end

function table.find(t,value)
  for k,v in pairs(t) do
    if v == value then
      return k
    end
  end
  return false
end

pwd = io.popen("echo %cd%"):read('*l').."\\src\\"
dayList = {}

for fileName in io.popen([[dir "]]..pwd..[[" /B /AD]]):lines() do
  if string.match(fileName,"Day [0-9]+") then
    table.insert(dayList, fileName)
  end
end

repeat
  repeat
    io.write("What day do you want to solve? ")
    day = io.read()
    if string.match(day,"%d+[-.]%d+") then
      if string.find(day,"-") then
        star = string.sub(day,string.find(day,"-")+1)
        day = string.sub(day,1,string.find(day,"-")-1)
      elseif string.find(day,".") then
        star = string.sub(day,string.find(day,"%.")+1)
        day = string.sub(day,1,string.find(day,"%.")-1)
      end
    elseif string.match(day, "%d+") then
      star = 1
    end
  until tonumber(day) ~= nil or day == "exit"

  local dayFolder = "Day "..day
  if table.find(dayList,dayFolder) then
    print()
    xpcall(loadfile(pwd..dayFolder.."/main.lua"),print,star)
  elseif tonumber(day) ~= nil then
    print("This day has not yet been solved.")
  end
  print()
until day == "exit"