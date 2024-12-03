local U = require("util")

local mem = U.readFile("./input.txt")
local sum = 0

for mulStr in mem:gmatch("mul%(%d+,%d+%)") do
  print(mulStr)
  local product = 1
  for n in mulStr:gmatch("%d+") do
    product = product * n
  end
  sum = sum + product
end

print(sum)
