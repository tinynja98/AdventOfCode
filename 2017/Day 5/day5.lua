local pwd = fs.getscriptdir(debug.getinfo(1).source)
local memory1,k1,temp1,steps1 = {},1,0,0
local memory2,k2,temp2,steps2 = {},1,0,0

local i = 0
for l in io.open(pwd.."input.txt"):lines("*l") do
	i = i+1
	if tonumber(l) ~= nil then
		table.insert(memory1,tonumber(l))
		table.insert(memory2,tonumber(l))
	else
		error("Invalid instruction given in \"input.txt\" on line "..i.." (\""..l.."\")")
	end
end

repeat
	--Part 1
	if k1 >= 1 and k1 <= #memory1 then
		temp1 = k1+memory1[k1]
		memory1[k1] = memory1[k1]+1
		k1 = temp1
		steps1 = steps1+1
	end
	--Part 2
	if k2 >= 1 and k2 <= #memory2 then
		temp2 = k2+memory2[k2]
		if memory2[k2] >= 3 then
			memory2[k2] = memory2[k2]-1
		else
			memory2[k2] = memory2[k2]+1
		end
		k2 = temp2
		steps2 = steps2+1
	end
until (k1 < 1 or k1 > #memory1) and (k2 < 1 or k2 > #memory2)

print("Part 1: "..steps1.." steps")
print("Part 2: "..steps2.." steps")