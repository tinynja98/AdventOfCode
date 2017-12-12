local pwd,input,inputs = getScriptDir(debug.getinfo(1).source),"",{}
local file = io.open(pwd.."input.txt")

if file then 
	if file:read("*a") ~= nil then
		local i = 0
		for l in file:lines() do
			i = i+1
			local editL = l
			editL = editL:gsub(" ","")
			table.insert(inputs,editL)
			if modL:match("%a+\\(%d+\\)->[a-zA-Z,]+") then
				editL:gsub("%a+\\(%d+\\)->","")
				repeat
					if not editL:match("%a+,") and not editL:match("%a+") then
						print("Syntax error in \"input.txt\" on line #"..i.." ("..l..")")
						inputs = {}
						break
					end
					editL:gsub("%a+,","",1)
				until editL:match("%a+")
			else
				print("Syntax error in \"input.txt\" on line #"..i.." ("..l..")")
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
		input = io.read()
		input = input:gsub(" ","")
		if input:match("%a+\\(%d+\\)->[a-zA-Z,]+") then
			table.insert(inputs,input)
		end
	until (input == "stop" and #inputs > 0) or input == "exit" or input == "reload"
end

