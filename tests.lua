--[[
if _tostring == nil then _tostring = tostring end
function tostring(...)
	local args,strings = {...},{}
	if #args > 0 then
		for i = 1,#args do
			_tostring(args[i])
			table.insert(strings,_tostring(args[i]))
		end
		return table.unpack(strings)
	else
		return "nil"
	end
end
]]

if _tonumber == nil then _tonumber = tonumber end
function tonumber(...)
	local args,numbers = {...},{}
	for i = 1,#args do
		table.insert(numbers,_tonumber(args[i]))
	end
	return table.unpack(numbers)
end

if table._unpack == nil then table._unpack = table.unpack end
function table.unpack()
	
end

function alphabetical(s1,s2,returnstring)
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

function table.find(t,value)
	local indexes = {}
	if t ~= nil and value ~= nil then
		for k,v in pairs(t) do
			if v == value then
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

x = {}
--x = { "2",y = { z = {"2"} },a = {"2"}, "2", "2"}

print(table._unpack())