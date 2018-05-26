local input1,lengthsuffix,input2 = {88,88,211,106,141,1,78,254,2,111,77,255,90,0,54,205},{17,31,73,47,23},'88,88,211,106,141,1,78,254,2,111,77,255,90,0,54,205'

function genlist(n)
	local list = {}
	for i = 0,n do
		list[i] = i
	end
	return list
end

local function knot_round(list,cpos,skipsize,lengths)
	for i = 1,#lengths do
		local length = lengths[i]
		for j = 0,math.ceil(length/2)-1 do
			list[(cpos+j)%256],list[(cpos+length-1-j)%256] = list[(cpos+length-1-j)%256],list[(cpos+j)%256]
		end
		cpos = (cpos+length+skipsize)%256
		skipsize = skipsize+1
	end
	return list,cpos,skipsize
end

local part1 = knot_round(genlist(255),0,0,input1)
part1 = part1[0]*part1[1]

for i = input2:len(),1,-1 do
	table.insert(lengthsuffix,1,input2:byte(i,i))
end
input2 = lengthsuffix

local sparsehash,cpos2,skipsize2 = genlist(255),0,0
for i = 1,64 do
	sparsehash,cpos2,skipsize2 = knot_round(sparsehash,cpos2,skipsize2,input2)
end

local densehash = {}
for i = 0,15 do
	densehash[i+1] = sparsehash[i*16]
	for j = 1,15 do
		densehash[i+1] = densehash[i+1]~sparsehash[i*16+j]
	end
end

local part2 = ''
for i = 1,#densehash do
	part2 = part2..string.format('%02x',densehash[i])
end

print('Part 1: '..part1)
print('Part 2: '..part2)