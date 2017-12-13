if _tostring == nil then _tostring = tostring end
function tostring(...)
	local args = {...}
	local strings = {}
	for i = 1,#args do
	--local strings = {_tostring(args[1])}
	--for i = 2,#args do
		table.insert(strings,_tostring(args[i]))
	end
	return table.unpack(strings)
end

x = {}

print(next(x))