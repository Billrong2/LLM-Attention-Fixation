local function f(text, sep, maxsplit)
    local splitted = {}
    for w in text:gmatch("[^" .. sep .. "]+") do
        table.insert(splitted, w)
    end
    local length = #splitted
    local new_splitted = {}
    for i = 1, math.floor(length / 2) do
        table.insert(new_splitted, splitted[length - i + 1])
    end
    for i = math.floor(length / 2) + 1, length do
        table.insert(new_splitted, splitted[i])
    end
    return table.concat(new_splitted, sep)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ertubwi', 'p', 5), 'ertubwi')
end

os.exit(lu.LuaUnit.run())
