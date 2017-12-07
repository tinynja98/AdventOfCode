if utils then
	io.write("Reloaded utils.lua.\n")
else
	utils = true
end

function toboolean(v)
	if type(v) == "boolean" then
		return v
	elseif type(v) == "number" then
		if v == 1 then return true end
	elseif type(v) == "string" then
		if v == "true" then return true end
	end
	return false
end

if _tonumber == nil then _tonumber = tonumber end
function tonumber(...)
	local args,numbers = {...},{}
	for i = 1,#args do
		table.insert(numbers,_tonumber(args[i]))
	end
	return table.unpack(numbers)
end

function table.find(t,value)
	local mink = math.huge
  for k,v in pairs(t) do
		if v == value then
			mink = math.min(mink,k)
    end
	end
	if mink ~= math.huge then
		return mink
	else
		return false
	end
end

function string.cut(s,pattern,remPattern,i)
	local i2 = 0
	if remPattern == nil then remPattern = true end
  if pattern == nil then pattern = " " end
	if tonumber(i) ~= nil then i2 = i-1 end
	local cutstring = {}
	repeat
		local i1 = i2
    i2 = s:find(pattern,i1+1)
		if i2 == nil then i2 = s:len()+1 end
		if remPattern then
			table.insert(cutstring,s:sub(i1+1,i2-1))
		else
			table.insert(cutstring,s:sub(i1,i2-1))
		end
	until i2 == s:len()+1
  return cutstring
end

function getScriptDir(source)
	if source == nil then
		source = debug.getinfo(1).source
	end
	local pwd = ""
	local pwd1 = (io.popen("echo %cd%"):read("*l")):gsub("\\","/")
	local pwd2 = source:sub(2):gsub("\\","/")
	if pwd2:sub(2,3) == ":/" then
		pwd = pwd2:sub(1,pwd2:find("[^/]*%.lua")-1)
	else
		local path1 = string.cut(pwd1:sub(4),"/")
		local path2 = string.cut(pwd2,"/")
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
	return pwd
end