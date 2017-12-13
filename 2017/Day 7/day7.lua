local pwd,input,inputs = getScriptDir(debug.getinfo(1).source),"",{}
local file = io.open(pwd.."input.txt")

if file then 
	if file:read("*a") ~= nil then
		local i = 0
		for l in file:lines() do
			i = i+1
			local modifiedL,validLine = l:gsub(" ",""),true
			table.insert(inputs,modifiedL) --MOVE THIS
			if modifiedL:gsub("%a+\\(%d+\\)",""):match(".+") then
				if modifiedL:match("%a+\\(%d+\\)->[a-zA-Z,]+") then
					modifiedL:gsub("%a+\\(%d+\\)->","")
					repeat
						if not modifiedL:match("%a+,") and not modifiedL:match("%a+") then
							validLine = false
							break
						end
						modifiedL:gsub("%a+,","",1)
					until modifiedL:match("%a+")
				else
					validLine = false
				end
			end
			if not validLine then
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
		if input == "exit" then error("exit")
		elseif input == "reload" then error("reload")
		end
		input = input:gsub(" ","")
		if input:match("%a+\\(%d+\\)->[a-zA-Z,]+") then
			table.insert(inputs,input)
		end
	until input == "stop" and #inputs > 0
end