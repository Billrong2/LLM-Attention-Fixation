local function f(a, b, c)
    local result = {}
    for _, d in ipairs({a, b, c}) do
        for _, value in ipairs(d) do
            result[value] = nil
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 3}, {1, 4}, {1, 2}), {[1] = None, [2] = None, [3] = None, [4] = None})
end

os.exit(lu.LuaUnit.run())
