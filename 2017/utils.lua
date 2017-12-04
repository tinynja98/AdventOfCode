function table.find(t,value)
  for k,v in pairs(t) do
    if v == value then
      return k
    end
  end
  return false
end

function string.cut(s,pattern)
  if pattern == nil then pattern = " " end
  local cutstring = {}
  local i1 = 0
  repeat
    i2 = nil
    local i2 = string.find(s,pattern,i1+1)
    if i2 == nil then i2 = string.len(s)+1 end
    table.insert(cutstring,string.sub(s,i1+1,i2-1))
    i1 = i2
  until i2 == string.len(s)+1
  return cutstring
end