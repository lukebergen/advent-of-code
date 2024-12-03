local U = require("util")

local mem = U.readFile("./input.txt")
local sum = 0

for x,y in mem:gmatch("mul%((%d+),(%d+)%)") do
  print(x * y)
  sum = sum + (x * y)
end

print(sum)

-- 156388521
