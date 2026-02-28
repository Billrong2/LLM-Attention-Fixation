local function f(d)
    local sorted_pairs = {}
    for k, v in pairs(d) do
        table.insert(sorted_pairs, {key=k, value=v})
    end
    table.sort(sorted_pairs, function(a, b) return #tostring(a.key..a.value) < #tostring(b.key..b.value) end)
    
    local result = {}
    for _, pair in ipairs(sorted_pairs) do
        if pair.key < pair.value then
            table.insert(result, {pair.key, pair.value})
        end
    end
    
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[55] = 4, [4] = 555, [1] = 3, [99] = 21, [499] = 4, [71] = 7, [12] = 6}), {{1, 3}, {4, 555}})
end

os.exit(lu.LuaUnit.run())
