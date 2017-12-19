local pwd = getScriptDir(debug.getinfo(1).source)
local file,args,input,xdif,ydif = io.open(pwd.."input.txt"),{...},"",0,0
local gifts1,x1,y1,houses1 = {[0]={[0]=1}},0,0,1
local gifts2,x2s,y2s,x2r,y2r,houses2 = {[0]={[0]=2}},0,0,0,0,1

function resolve(t,x,y,h)
	if t[x] == nil then
		t[x] = {}
	end
	if t[x][y] == nil then
		t[x][y] = 1
		h = h+1
	else
		t[x][y] = t[x][y]+1
	end
	return h
end

if file and file:read("*l") ~= nil then
	file:seek("set")
	local line = file:read("*l")
	if not line:match("[^\\^v<>]") then
		input = line
	end
	file:close()
end

if args[1] ~= nil and not args[1]:match("[^\\^v<>]") then
	input = args[1]
elseif input == "" then
	repeat
		io.write("Input: ")
		input = io.read()
	until not input:match("[^\\^v<>]")
end

for i = 1,input:len() do
	if input:sub(i,i) == "^" then
		xdif = 0
		ydif = 1
	elseif input:sub(i,i) == "v" then
		xdif = 0
		ydif = -1
	elseif input:sub(i,i) == "<" then
		xdif = -1
		ydif = 0
	elseif input:sub(i,i) == ">" then
		xdif = 1
		ydif = 0
	end
	--Part 1
	x1 = x1+xdif
	y1 = y1+ydif
	houses1 = resolve(gifts1,x1,y1,houses1)
	--Part 2
	if i%2 == 0 then
		x2r = x2r+xdif
		y2r = y2r+ydif
		houses2 = resolve(gifts2,x2r,y2r,houses2)
	else
		x2s = x2s+xdif
		y2s = y2s+ydif
		houses2 = resolve(gifts2,x2s,y2s,houses2)
	end
end

print("Part 1: "..houses1.." houses")
print("Part 2: "..houses2.." houses")