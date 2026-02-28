local function f(counts)
    local dict = {}
    for k, v in pairs(counts) do
        local count = counts[k]
        if not dict[count] then
            dict[count] = {}
        end
        table.insert(dict[count], k)
    end
    for k, v in pairs(dict) do
        counts[k] = v
    end
    return counts
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['2'] = 2, ['0'] = 1, ['1'] = 2}), {['2'] = 2, ['0'] = 1, ['1'] = 2, [2] = {'2', '1'}, [1] = {'0'}})
end

os.exit(lu.LuaUnit.run())
