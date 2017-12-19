local args = {...}

local function parseError(msg)
	if msg:match("exit") or msg:match("interrupted!") then
		return true
	elseif not msg:match("reload") then
		print(msg)
	end
	io.write("\n")
	return false
end

local function cut(s,pattern,delpattern,i)
  if type(s) ~= "string" then error("bad argument #1 to 'string.cut' (string expected, got "..type(t)..")") end
  if type(pattern) ~= "string" then error("bad argument #2 to 'string.cut' (string expected, got "..type(t)..")") end
	local i2 = 0
	if delpattern == nil then delpattern = true end
	if tonumber(i) ~= nil then i2 = i-1 end
	local cutstring = {}
	repeat
		local i1 = i2
    i2 = s:find(pattern,i1+1)
		if i2 == nil then i2 = s:len()+1 end
		if delpattern then
			table.insert(cutstring,s:sub(i1+1,i2-1))
		else
			table.insert(cutstring,s:sub(i1,i2-1))
		end
	until i2 == s:len()+1
  return cutstring
end

local function getScriptDir(source) --requires: cut
	if source == nil then
		source = debug.getinfo(1).source
	end
	local pwd = ""
	local pwd1 = (io.popen("echo %cd%"):read("*l")):gsub("\\","/")
	local pwd2 = source:sub(2):gsub("\\","/")
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
	return pwd
end

local pwd,cut,getScriptDir = getScriptDir(),nil,nil

repeat
	xpcall(loadfile(pwd.."path.lua"),parseError)
	xpcall(loadfile(pwd.."utils.lua"),parseError)
	local exit = select(2,xpcall(loadfile(pwd.."loader.lua"),parseError,table.unpack(args,1)))
until	exit