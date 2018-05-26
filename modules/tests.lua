x = 'a,b,c'

y = x:cut(',')

for k,v in pairs(y) do
	print(k,v)
end