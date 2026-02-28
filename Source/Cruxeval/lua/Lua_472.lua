local function f(text)
    local d = {}
    text = text:gsub('-', ''):lower()
    for char in text:gmatch(".") do
        d[char] = (d[char] or 0) + 1
    end
    local sorted_d = {}
    for key, value in pairs(d) do
        table.insert(sorted_d, {key = key, value = value})
    end
    table.sort(sorted_d, function(a, b) return a.value < b.value end)
    local result = {}
    for i, entry in ipairs(sorted_d) do
        table.insert(result, entry.value)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('x--y-z-5-C'), {1, 1, 1, 1, 1})
end

os.exit(lu.LuaUnit.run())
