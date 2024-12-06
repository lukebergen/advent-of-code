local U = require("util")

local lines = U.fileLines("./input.txt")
local height = #lines
local width = #lines[1]

local function check(chars, row, col)
  if chars[row][col] ~= "A" then
    return false
  end

  local topLeft = chars[row-1][col-1]
  local topRight = chars[row-1][col+1]
  local bottomLeft = chars[row+1][col-1]
  local bottomRight = chars[row+1][col+1]

  local backSlash = (topLeft == "M" and bottomRight == "S") or (topLeft == "S" and bottomRight == "M")
  local forwardSlash = (bottomLeft == "M" and topRight == "S") or (bottomLeft == "S" and topRight == "M")

  return backSlash and forwardSlash
end

local chars = {}
for _, line in ipairs(lines) do
  table.insert(chars, U.chars(line))
end

local count = 0
for row = 2, height - 1 do
  for col = 2, width - 1 do
    -- search for all the "A"s and then see if they create an X-MAS
    if check(chars, row, col) then
      print(row .. "," .. col .. "  " .. chars[row-1][col-1] .. chars[row][col] .. chars[row+1][col+1] .. "  " .. chars[row+1][col-1] .. chars[row][col] .. chars[row-1][col+1])
      count = count + 1
    end
  end
end

print(count)
