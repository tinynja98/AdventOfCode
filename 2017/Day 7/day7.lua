local pwd,input,inputs = fs.getscriptdir(debug.getinfo(1).source),"",{}
local file = io.open(pwd.."input.txt")

if file then 
	if file:read("*a") ~= nil then
		file:seek("set")
		local i = 0
		for l in file:lines() do
			i = i+1
			local modifiedL,validLine = l:gsub(" ",""),true
			table.insert(inputs,modifiedL)
			if modifiedL:match("%a+%(%d+%)") then
				if modifiedL:match("%a+%(%d+%)%->[a-zA-Z,]+") then
					modifiedL = modifiedL:gsub("%a+%(%d+%)%->","")
					if modifiedL:gsub("%a+,",""):gsub("%a+","",1) ~= "" then
						validLine = false
					end
				elseif modifiedL:gsub("%a+%(%d+%)",""):match(".+") then
					validLine = false
				end
			else
				validLine = false
			end
			if not validLine then
				print("Syntax error in input.txt on line "..i..": \""..l.."\"")
				inputs = {}
				break
			end
		end
	end
	file:close()
end

if #inputs == 0 then
	repeat
		io.write("Input "..(#inputs+1)..": ")
		input = io.read():gsub(" ","")
		if input == "exit" then error("exit")
		elseif input == "reload" then error("reload")
		end
		if input:match("%a+%(%d+%)%->[a-zA-Z,]+") then
			table.insert(inputs,input)
		end
	until input == "stop" and #inputs > 0
end

local tree = {}
for i = 1,#inputs do
	local parent,weight,children,childrenDup,iofinterest = "",0,{},{},{}
	parent = inputs[i]:match("%a+")
	weight = inputs[i]:match("%d+")
	if inputs[i]:match("%->") then
		local init = select(2,inputs[i]:find("%->"))
		repeat
			table.insert(children,inputs[i]:match("%a+",init))
			table.insert(childrenDup,inputs[i]:match("%a+",init))
			init = select(2,inputs[i]:find("%a+",init))+1
		until inputs[i]:match("%a+",init) == nil
	end
	for k,v in pairs(tree) do
		if k:match(parent) then
			parent = k
		else
			for i = 1,#children do
				if k:match(children[i]) then
					table.insert(iofinterest,k)
					if k:match("("..children[i]..")$") then
						table.remove(childrenDup,table.find(childrenDup,children[i]))
					end
				end
			end
		end
	end
	tree[parent] = weight
	for i = 1,#childrenDup do
		table.insert(iofinterest,childrenDup[i])
	end
	for i = 1,#iofinterest do
		if tree[iofinterest[i]] then
			tree[parent..":"..iofinterest[i]] = tree[iofinterest[i]]
			tree[iofinterest[i]] = nil
		else
			tree[parent..":"..iofinterest[i]] = 0
		end
	end
end

for k,v in pairs(tree) do
	if k:gsub("%a+","",1) == "" then
		print("Part 1: "..k)
		break
	end
end

for k,v in orderedPairs(tree) do
	io.write(k)
	if io.read() == "exit" then error("exit") end
end