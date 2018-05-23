pwd = fs.getscriptdir(debug.getinfo(1).source)
local file,input = io.open(pwd.."input.txt"),""

function validateBanks(b)
	local b = string.cut(b:gsub("\9"," ")," ")
	for i = 1,#b do
		if tonumber(b[i]) == nil then
			return false,i
		end
	end
	return true
end

if file and file:read("*l") ~= nil then
	file:seek("set")
	input = file:read("*l")
	file:close()
end

if arg[1] ~= nil and validateBanks(arg[1]) then
	input = arg[1]
elseif input == "" or not validateBanks(input) then
	if input == "" then
		print("\"input.txt\" not found or empty")
	elseif not validateBanks(input) then
		local validation,bankNumber = validateBanks(input)
		print("Invalid number of blocks in bank #"..bankNumber.." in \"input.txt\"")
	end
	repeat
		io.write("Input: ")
		input = io.read()
	until validateBanks(input)
end

local blocks,banks,bankString,i = string.cut(input:gsub("\9"," ")," "),{},"",0
for i = 1,#blocks do
	blocks[i] = tonumber(blocks[i])
	bankString = bankString.." "..blocks[i]
end

repeat
	table.insert(banks,bankString)
	local chosen1v = math.max(table.unpack(blocks))
	local chosen1k = table.find(blocks,chosen1v)
	bankString = ""
	blocks[chosen1k] = 0
	for i = 1,#blocks do
		blocks[i] = blocks[i]+math.floor(chosen1v/(#blocks))
		if (i-chosen1k)%(#blocks) > 0 and (i-chosen1k)%(#blocks) <= chosen1v then
			blocks[i] = blocks[i]+1
		end
		bankString = bankString.." "..blocks[i]
	end
until	table.find(banks,bankString)

print("Part 1: "..(#banks).." cycles")
print("Part 2: "..(#banks-table.find(banks,bankString)+1).." cycles per loop")