local pwd = getScriptDir(debug.getinfo(1).source)
local validPass1,validPass2 = 0,0

for l in io.lines(pwd.."input.txt") do
  local words,sortedWords = string.cut(l," "),{}
  local valid1,valid2 = true,true
  for i1 = 1,#words do
    --Part 1
    for i2 = i1+1,#words do
      if words[i1] == words[i2] then
        valid1 = false
      end
      if not valid1 then break end
    end
    --Part 2
    local letters = {}
    for i2 = 1,string.len(words[i1]) do
      table.insert(letters,string.sub(words[i1],i2,i2))
    end
    table.sort(letters)
    local word = ""
    for i2 = 1,#letters do
      word = word..letters[i2]
    end
    table.insert(sortedWords,word)
  end
  for i1 = 1,#sortedWords do
    for i2 = i1+1,#sortedWords do
      if sortedWords[i1] == sortedWords[i2] then
        valid2 = false
      end
      if not valid2 then break end
    end
    if not valid2 then break end
  end
  if valid1 then
    validPass1 = validPass1+1
  end
  if valid2 then
    validPass2 = validPass2+1
  end
end

print("Part 1: "..validPass1.." valid passwords.")
print("Part 2: "..validPass2.." valid passwords.")