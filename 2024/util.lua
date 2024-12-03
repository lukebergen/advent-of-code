local M = {}

M.fileLines = function(fileName)
  local file = io.open(fileName, "r")
  local contents
  if file then
    contents = file:read("*a")
    file:close()
  else
    print("uhoh")
    os.exit(1)
  end

  local result = {}

  for line in contents:gmatch("[^\n]*") do
    if line ~= "" then
      table.insert(result, line)
    end
  end
  return result
end

M.split = function(str, delimiter)
  local result = {}
  for match in (str..delimiter):gmatch("([^"..delimiter.."]+)") do
      table.insert(result, match)
  end
  return result
end

M.map = function(arr, callback)
  local r = {}
  for _, e in ipairs(arr) do
    table.insert(r, callback(e))
  end
  return r
end

return M
