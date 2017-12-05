pwd = (io.popen("echo %cd%"):read('*l').."\\") --C:\Dev\AdventOfCode
local pwdComp = debug.getinfo(1).source --@2017\main.lua
local p3,p4 = pwdComp:find("main.lua")
local p1,p2 = pwdComp:upper():find(pwd:upper())
if not p2 then p2 = 1 end
pwd = (pwd..pwdComp:sub(p2+1,p3-1)):gsub("\\","/")
dofile(pwd:sub(1,pwd:find("2017")-1).."main.lua")