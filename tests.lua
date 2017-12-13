function test(...)
	return table.unpack({...})
end

y = {1,nil,3}

for i = 1,#y do
	print(i,y[i])
end

print(test("a",nil,"a"))