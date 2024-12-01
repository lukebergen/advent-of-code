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
    table.insert(list1, bits[1])
    table.insert(list2, bits[2])
  end
end

table.sort(list1)
table.sort(list2)

local sumOfDiffs = 0
for i = 1, #list1 do
  sumOfDiffs = sumOfDiffs + math.abs(list1[i] - list2[i])
end

print(sumOfDiffs)
