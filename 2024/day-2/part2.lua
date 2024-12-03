local U = require("util")

local lines = U.fileLines("./input.txt")

local good = 0

local function check(ns)
  local dir = 0
  for i = 1, #ns - 1 do
    dir = dir + ns[i+1] - ns[i]
  end
  if dir > 0 then
    dir = 1
  else
    dir = -1
  end

  local last = ns[1]

  for i = 2, #ns do
    local n = ns[i]
    local diff = (n - last) * dir
    if diff > 3 or diff <= 0 then
      return false
    end

    last = n
  end

  return true
end

local function rip(t, index)
  local ripped = {}
  for i = 1, #t do
    if i ~= index then
      table.insert(ripped, t[i])
    end
  end
  return ripped
end

for _, line in ipairs(lines) do
  local ns = U.map(U.split(line, " "), function(n) return tonumber(n) end)

  if check(ns) then
    good = good + 1
  else
    -- ugh. It's a bad one. Suuuper naive approach... But will help find the actual problems. Then improve
    local isGood = false
    for i = 1, #ns do
      if check(rip(ns, i)) then
        isGood = true
      end
    end
    if isGood then
      good = good + 1
    else
      --print(line)
    end
  end
end

print(good)
