pwd = string.upper(io.popen("echo %cd%"):read('*l').."\\")
local pwdComplement = string.gsub(string.upper(debug.getinfo(1).source:sub(2)),pwd,"")
pwd = string.gsub(pwd..string.sub(pwdComplement,0,string.find(pwdComplement,"MAIN.LUA")-1),"\\","/")
dofile(string.sub(pwd,1,string.find(pwd,"2017")-1).."main.lua")