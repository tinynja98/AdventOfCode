x = {"a","b","c",a=5}

for k,v in pairs(x) do
	print(k,v)
end

table.shift(x,-2)
io.write("\n")

for k,v in orderedPairs(x) do
	print(k,v)
end