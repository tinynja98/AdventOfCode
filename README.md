# Advent Of Code

[Advent of Code](http://adventofcode.com) is a daily series of small programming puzzles for a variety of skill levels for the month of december, each day supposedly getting harder. This is my attempt at solving these puzzles using **Lua**.

You can either run _main.lua_ or _YEAR/aocYEAR.lua_

**Note:** I have written this project on Windows, so you will have to change a few lines if you want to use it on another OS, specifically...

main.lua:
 * line 21 `io.popen("echo %cd%")`
 * line 54 `io.popen("dir \""..pwd.."\" /B /AD")`
 * line 82 `io.popen("dir \""..pwd..year.."\" /B /AD")`
 * line 88 `io.popen("if exist \""..pwd..year.."/"..dayFolder.."/day"..inputs[1]..".lua\" echo true")`

utils.lua:
 * line 39 `io.popen("echo %cd%")`
 * line 42 `pwd2:sub(2,3) == ":/"`

YEAR/aocYEAR.lua:
 * line 19 `io.popen("echo %cd%")`
 * line 22 `pwd2:sub(2,3) == ":/"`