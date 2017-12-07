local function cut(s,pattern)
	if pattern == nil then
		pattern = " "
	end
	local cutstring = {}
	local i1 = 0
	repeat
		i2 = nil
		local i2 = string.find(s,pattern,i1+1)
		if i2 == nil then
			i2 = string.len(s)+1
		end
		table.insert(cutstring,string.sub(s,i1+1,i2-1))
		i1 = i2
	until i2 == string.len(s)+1
	return cutstring
end

local pwd1 = (io.popen("echo %cd%"):read("*l")):gsub("\\","/")
local pwd2 = debug.getinfo(1).source:sub(2):gsub("\\","/")
local pwd = ""
if pwd2:sub(2,3) == ":/" then
	pwd = pwd2:sub(1,pwd2:find("[^/]*%.lua")-1)
else
	local path1 = cut(pwd1:sub(4),"/")
	local path2 = cut(pwd2,"/")
	for i = 1,#path2-1 do
		if path2[i] == ".." then
			table.remove(path1)
		else
			table.insert(path1,path2[i])
		end
	end
	pwd = pwd1:sub(1,3)
	for i = 1,#path1 do
		pwd = pwd..path1[i].."/"
	end
end

cut = nil

loadfile(pwd:sub(1,pwd:find("2016")-1).."loader.lua")(2016)