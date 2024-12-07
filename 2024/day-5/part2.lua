local U = require("util")

local lines = U.fileLines("./input.txt")

-- rules represent failure states. If ever rules[x][y] is true, that means "STOP"
local rules = {}
local updates = {}

local function newRule(rule)
  -- rule = {1, 5}
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

local bads = {}

for _, update in ipairs(updates) do
  if not updateGood(update) then
    table.insert(bads, update)
  end
end

local function fix(update)
  -- figure out which pair is broken
  local isBroke = true
  while isBroke do
    isBroke = false
    for i = 1, #update do
      for j = i+1, #update do
        if rulesBroken(update[i], update[j]) then
          isBroke = true
          local temp = update[i]
          update[i] = update[j]
          update[j] = temp
        end
      end
    end
  end
  return update
end

local fixed = {}
for _, bad in ipairs(bads) do
  table.insert(fixed, fix(bad))
end

local sum = 0
for _, f in ipairs(fixed) do
  local m = f[(#f+1) / 2]
  sum = sum + m
end

print(sum)
