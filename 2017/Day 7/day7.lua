local pwd,input,inputs = fs.getscriptdir(debug.getinfo(1).source),"",{}
local file = io.open(pwd.."input.txt")

local function verify_masses(t)
	local masses,index = {},{}
	for k,v in pairs(t) do
		if index[k:gsub('_children','')] == nil then
			index[k:gsub('_children','')] = #masses+1
			masses[index[k:gsub('_children','')]] = 0
			masses[-index[k:gsub('_children','')]] = k:gsub('_children','')
		end
		if type(v) == 'number' then
			masses[index[k:gsub('_children','')]] = masses[index[k:gsub('_children','')]]+v
		elseif type(v) == 'table' then
			local children_result = verify_masses(v)
			if type(children_result) == 'string' then
				return children_result
			elseif type(children_result) == 'number' then
				masses[index[k:gsub('_children','')]] = masses[index[k:gsub('_children','')]]+children_result
			end
		end
	end
	local sum = 0
	for i = 1,#masses do
		sum = sum+masses[i]
		if masses[i] ~= masses[(i-2)%#masses+1] and masses[i] ~= masses[i%#masses+1] then
			return masses[-i]..':'..(masses[i%#masses+1]-masses[i])
		end
	end
	return sum
end

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

local tree_1dim = {}
for i = 1,#inputs do
	local parent,weight,children,childrenDup,iofinterest = "",0,{},{},{}
	parent = inputs[i]:match("%a+")
	weight = tonumber(inputs[i]:match("%d+"))
	if inputs[i]:match("%->") then
		local init = select(2,inputs[i]:find("%->"))
		repeat
			table.insert(children,inputs[i]:match("%a+",init))
			table.insert(childrenDup,children[#children])
			init = select(2,inputs[i]:find("%a+",init))+1
		until inputs[i]:match("%a+",init) == nil
	end
	for k,v in pairs(tree_1dim) do
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
	tree_1dim[parent] = weight
	for i = 1,#childrenDup do
		table.insert(iofinterest,childrenDup[i])
	end
	for i = 1,#iofinterest do
		if tree_1dim[iofinterest[i]] then
			tree_1dim[parent..":"..iofinterest[i]] = tree_1dim[iofinterest[i]]
			tree_1dim[iofinterest[i]] = nil
		else
			tree_1dim[parent..":"..iofinterest[i]] = 0
		end
	end
end

local tree,part1 = {},nil
for k,v in pairs(tree_1dim) do
	local disks,latest_table = string.cut(k,':'),tree
	for i = 1,#disks do
		part1 = part1 or disks[i]
		if latest_table[disks[i]..'_children'] == nil then
			latest_table[disks[i]..'_children'] = {}
		end
		if i ~= #disks then
			latest_table = latest_table[disks[i]..'_children']
		end
	end
	latest_table[disks[#disks]] = v
end

local part2 = verify_masses(tree)
part2 = tonumber(part2:sub(part2:find(':')+1))+tree_1dim[table.find(tree,part2:sub(1,part2:find(':')-1),'k'):gsub('_children',''):gsub('%.',':')]

print('Part 1: '..part1)
print('Part 2: '..part2)