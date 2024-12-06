local U = require("util")

local lines = U.fileLines("./input.txt")
local height = #lines
local width = #lines[1]

local function check(chars, row, col, rowOffset, colOffset)
  -- how do we check boundaries efficiently...
  if col < 1 or (col + (colOffset * 3)) < 1 or
     col > width or (col + (colOffset * 3)) > width or
     row < 1 or (row + (rowOffset * 3)) < 1 or
     row > height or (row + (rowOffset * 3)) > height then
    return false
  end
  if chars[row][col] == "X" and
     chars[row + (rowOffset * 1)][col + (colOffset * 1)] == "M" and
     chars[row + (rowOffset * 2)][col + (colOffset * 2)] == "A" and
     chars[row + (rowOffset * 3)][col + (colOffset * 3)] == "S" then
    return true
  end
end

local chars = {}
for _, line in ipairs(lines) do
  table.insert(chars, U.chars(line))
end

local count = 0
for row = 1, height do
  for col =1, width do
    -- check in every direction I guess?
    for i = -1, 1 do
      for j = -1, 1 do
        if check(chars, row, col, i, j) then
          count = count + 1
        end
      end
    end
  end
end

print(count)
