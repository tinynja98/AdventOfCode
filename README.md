# Advent Of Code

[Advent of Code](http://adventofcode.com) is a daily series of small programming puzzles for a variety of skill levels for the month of december, each day allegedly getting harder. This is my attempt at solving these puzzles using **Lua 5.3.4**.

You need to run **`main.lua`**.

**Note:** Since Lua does not have many filesystem capabilities, I had to use external commands. Therefore, if you want to run this script on a different OS than Windows, you will have to modify these lines...

path.lua:
 * line 6 `io.popen("echo %cd%")`
 * line 8 `pwd2:sub(2,3) == ":/"`

main.lua:
 * line 38 `io.popen("echo %cd%")`
 * line 40 `pwd2:sub(2,3) == ":/"`

loader.lua:
 * line 24 `io.popen("dir \""..pwd.."\" /B /AD")`
 * line 56 `io.popen("dir \""..pwd..year.."\" /B /AD")`
 * line 62 `io.popen("if exist \""..pwd..year.."/"..dayFolder.."/day"..inputs[1]..".lua\" echo true")`