# Advent Of Code

[Advent of Code](http://adventofcode.com) is a daily series of small programming puzzles for a variety of skill levels for the month of december, each day supposedly getting harder. This is my attempt at solving these puzzles using **Lua**.

Note: You can either run _/main.lua_ or _/YEAR/main.lua_

**_P.S._** I have written this project on Windows, so you will have to change a few parts of the code, specifically** `io.popen([[dir "]]..pwd..[[" /B /AD]])` and `io.popen("echo %cd%")` in _main.lua_; `io.popen("echo %cd%")` in _YEAR/main.lua_.