local U = require("util")

local lines = U.fileLines("./input.txt")

-- rules represent failure states. If ever rules[x][y] is true, that means "STOP"
local rules = {}
local updates = {}

local function newRule(rule)
  if not rules[rule[2]] then
    rules[rule[2]] = {}
  end
  rules[rule[2]][rule[1]] = true
end

local fillingRules = true
for _, line in ipairs(lines) do
  if line == "--updates" then
    fillingRules = false
  elseif fillingRules then
    newRule(U.split(line, "|"))
  else
    table.insert(updates, U.split(line, ","))
  end
end

local function rulesBroken(a, b)
  return rules[a] and rules[a][b]
end

local function updateGood(update)
  -- update looks like {79, 72, 94, 83, 85}
  for i = 1, #update do
    for j = i+1, #update do
      if rulesBroken(update[i], update[j]) then
        local s = ""
        for _, x in ipairs(update) do
          s = s .. tostring(x) .. ","
        end
        return false
      end
    end
  end
  return true
end

local middles = {}
for _, update in ipairs(updates) do
  if updateGood(update) then
    table.insert(middles, update[(#update+1) / 2])
  end
end

local sum = 0
for _, m in ipairs(middles) do
  sum = sum + m
end

print(sum)
