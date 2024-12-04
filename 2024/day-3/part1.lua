local U = require("util")

local mem = U.readFile("./input.txt")

local function sumMuls(str)
  local sum = 0
  for x,y in mem:gmatch("mul%((%d+),(%d+)%)") do
    sum = sum + (x * y)
  end
  return sum
end

print(sumMuls(mem))

-- 156388521
