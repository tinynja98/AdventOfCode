local args = {...}
local sheet,xCur,yCur,xMax,yMax,input,row,column = {{20151125}},1,1,1,1,"3010,3019",0,0 -- sheet = {y={x=n}}

if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
	input = args[1]..","..args[2]
elseif args[1] ~= nil and args[1]:match("%d+[;, ]%d+") then
	input = args[1]
elseif args[1] ~= nil or args[1] == "custom" then
	repeat
		io.write("Input (row,column): ")
		input = io.read()
		if input == "exit" then
			error("exit")
		elseif input == "reload" then
			error("reload")
		elseif input == "default" then
			input = "3010,3019"
			print("Using 3010,3019...")
		end
	until input:match("%d+[;, ]%d+")
end

row,column = tonumber(table.unpack(string.cut(input,"[;, ]")))

repeat
	if yCur == 1 then
		yMax = yMax+1
		xMax = xCur
		yCur = yMax
		xCur = 1
	else
		yCur = yCur-1
		xCur = xCur+1
	end
	if sheet[yCur] == nil then
		sheet[yCur] = {}
	end
	sheet[yCur][xCur] = sheet[yCur%yMax+1][(xCur-2)%xMax+1]*252533%33554393
until (yCur%yMax+1) == row and ((xCur-2)%xMax+1) == column

print("Part 1: "..sheet[row][column])