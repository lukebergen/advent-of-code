local U = require("util")

local mem = U.readFile("./input.txt")

local total = 0
local current = 1
local nextBadStart = mem:find("don't%(%)", current)

while nextBadStart do
  local stillLooking = true
  while stillLooking do
    local nextMulStart, _, x, y = mem:find("mul%((%d+),(%d+)%)", current)
    if nextMulStart == nil then -- if there are no more muls, just call it a day no matter what
      stillLooking = false
      current = #mem
    elseif nextMulStart > nextBadStart then -- if the next mul is in bad-town, ignore it and move us back up to good town
      local nextGoodTimes, _ = mem:find("do%(%)", nextBadStart)
      current = nextGoodTimes or #mem -- if there are no more good times to be had, skip to the end
      stillLooking = false -- time to find the next bad
    else
      -- found a mul and it's before the next don't()? Tally it up
      current = nextMulStart + 5
      total = total + (x * y)
    end
  end
  nextBadStart = mem:find("don't%(%)", current)
end

print(total)

-- 2814993378 (too high)
-- 75920122 (correct) (kinda cheated though by just using vim and macros and stuff to clean up the input)
-- 75920122 (got it again but straight from raw input. yay?)
