if utils then io.write("Reloaded utils.lua.\n") end
utils = true

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

if _tostring == nil then _tostring = tostring end
function tostring(...)
	local args = {table.unpack({...})}
	local strings = {_tostring(args[1])}
	for i = 2,#args do
		table.insert(strings,_tostring(args[i]))
	end
	return table.unpack(strings)
end

if _tonumber == nil then _tonumber = tonumber end
function tonumber(...)
	local args = {table.unpack({...})}
	local numbers = {_tonumber(args[1])}
	for i = 2,#args do
		table.insert(numbers,_tonumber(args[i]))
	end
	return table.unpack(numbers)
end

if string._byte == nil then string._byte = string.byte end
function string.byte(s,i,j)
	local ascii = {string._byte(s,i,j)}
	if ascii[1] == nil then
		return -1
	end
	return table.unpack(ascii)
end
 
function string.cut(s,pattern,delpattern,i)
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

function alphabetical(s1,s2,returnstring)
  if type(s1) ~= "string" then error("bad argument #1 to 'alphabetical' (string expected, got "..type(t)..")") end
  if type(s2) ~= "string" then error("bad argument #2 to 'alphabetical' (string expected, got "..type(t)..")") end
	local t,f = 0,0
	if returnstring then t,f = s1,s2
	else t,f = true,false
	end
	if not tostring(s1) and not tostring(s2) then return f
	elseif not tostring(s2) then return t
	elseif not tostring(s1) then return f
	else s1,s2 = tostring(s1,s2)
	end
	local low1,low2 = s1:lower(),s2:lower()
	local i = 0
	repeat
		i = i+1
		local l1,l2 = low1:byte(i,i),low2:byte(i,i)
		local r1,r2 = s1:byte(i,i),s2:byte(i,i)
		if tonumber(low1:sub(i,i)) ~= nil and tonumber(low2:sub(i,i)) ~= nil then
			l1,l2 = tonumber(low1:match("%d+",i),low2:match("%d+",i))
			i = math.max(low1:find("%d+"),low2:find("%d+"))
		end
		if l1 < l2 then return t
		elseif l2 < l1 then return f
		elseif r1 < r2 then return t
		elseif r2 < r1 then return f
		end
	until i == low1:len() or i == low2:len()
	return f
end

function table.find(t,value,kv)
  if type(t) ~= "table" then error("bad argument #1 to 'table.find' (table expected, got "..type(t)..")") end
	if type(value) == nil then error("bad argument #2 to 'table.find' (value expected, got "..type(value)..")") end
	if type(kv) ~= "string" then kv = "v" end
	local indexes = {}
	if t ~= nil and value ~= nil then
		for k,v in pairs(t) do
			if (kv:match("k") and k == value) or (kv:match("v") and v == value) then
				table.insert(indexes,k)
			elseif type(v) == "table" then
				local sufixes = {table.find(t[k],value)}
				if sufixes then
					for i = 1,#sufixes do
						table.insert(indexes,k.."."..sufixes[i])
					end
				end
			end
		end
		if next(indexes) ~= nil then
			table.sort(indexes,alphabetical)
			return table.unpack(indexes)
		end
	end
	return false
end