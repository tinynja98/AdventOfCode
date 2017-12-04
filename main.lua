local args = {...}

_loadfile = loadfile
function loadfile(file)
  return _loadfile(pwd..file)
end

_dofile = dofile
function dofile(file)
  return _dofile(pwd..file)
end

----------CODE----------


repeat
  repeat
    if pwd == nil then
      io.write("What year's puzzles are we solving? ")
      read = io.read()
      inputs = string.cut(read)
      pwd = string.upper(io.popen("echo %cd%"):read('*l').."\\")
      local pwdComplement = string.gsub(string.upper(debug.getinfo(1).source:sub(2)),pwd,"")
      pwd = string.gsub(pwd..string.sub(pwdComplement,0,string.find(pwdComplement,"MAIN.LUA")-1),"\\","/")
      if tonumber(inputs[1]) ~= nil then
        for fileName in io.popen([[dir "]]..pwd..[[" /B /AD]]):lines() do
          if string.match(fileName,"Day [0-9]+") then
            table.insert(dayList, fileName)
          end
        end
    
    io.write("What day do you want to solve? ")
    read = io.read()
    if tonumber(inputs[1]) ~= nil and inputs[1] ~= "exit" then
      for fileName in io.popen([[dir "]]..pwd..[[" /B /AD]]):lines() do
        if string.match(fileName,"Day [0-9]+") then
          table.insert(dayList, fileName)
        end
      end
    end
    inputs = string.cut(read," ")
  until tonumber(inputs[1]) ~= nil or inputs[1] == "exit"
  if inputs[1] ~= "exit" then
    local dayFolder = "Day "..inputs[1]
    if table.find(dayList,dayFolder) then
      io.write("\n")
      xpcall(loadfile(dayFolder.."/main.lua"),print,table.unpack(inputs,2))
    else
      print("That day has not yet been solved.")
    end
    io.write("\n")
  end
until inputs[1] == "exit"