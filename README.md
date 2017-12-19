# Advent Of Code

[Advent of Code](http://adventofcode.com) is a daily series of small programming puzzles for a variety of skill levels for the month of december, each day allegedly getting harder. This is my attempt at solving these puzzles using **Lua 5.3.4**.

**Note:** Since Lua does not have many filesystem capabilities, I had to use external commands. Therefore, if you want to run this script on a different OS than Windows, you will have to modify these lines...

_Misc/path.lua_:
 * line 6 `io.popen("echo %cd%")`
 * line 8 `pwd2:sub(2,3) == ":/"`

_Misc/main.lua_:
 * line 38 `io.popen("echo %cd%")`
 * line 40 `pwd2:sub(2,3) == ":/"`

_Misc/loader.lua_:
 * line 14 `io.popen("if exist \""..rootPath..y.."\" echo true")`
 * line 16 `io.popen("dir \""..rootPath..y.."\" /b /ad")`
 * line 35 `io.popen("if exist \""..rootPath..y.."/Day "..d.."/day"..d..".lua\" echo true")`