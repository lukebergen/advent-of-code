local file = io.open("./input.txt", "r")
local contents
if file then
  contents = file:read("*a")
  file:close()
else
  print("uhoh")
  os.exit(1)
end

local list1 = {}
local list2 = {}
for line in contents:gmatch("[^\n]*") do
  if line ~= "" then
    local bits = {}
    for bit in line:gmatch("%d+") do
      table.insert(bits, bit)
    end
    table.insert(list1, tonumber(bits[1]))
    table.insert(list2, tonumber(bits[2]))
  end
end

local multipliers = {}
for _, v in ipairs(list2) do
  if not multipliers[v] then
    multipliers[v] = 0
  end
  multipliers[v] = multipliers[v] + 1
end

print("multipliers...")
for k, v in pairs(multipliers) do
  print(k .. ': ' .. tostring(v))
end

local sum = 0
for _, n in ipairs(list1) do
  sum = sum + (n * (multipliers[n] or 0))
end

print(sum)
