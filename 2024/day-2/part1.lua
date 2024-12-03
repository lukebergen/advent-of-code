local U = require("util")

local lines = U.fileLines("./input.txt")

local good = 0
for _, line in ipairs(lines) do
  local ns = U.map(U.split(line, " "), function(n) return tonumber(n) end)
  local dir = ns[2] - ns[1]
  if dir > 0 then
    dir = 1
  else
    dir = -1
  end

  local last = ns[1] - dir -- start out one "before" the first number

  local isGood = true
  for _, n in ipairs(ns) do
    local diff = (n - last) * dir
    if diff > 3 or diff <= 0 then
      isGood = false
    end
    last = n
  end

  if isGood then
    good = good + 1
  end
end

print(good)
