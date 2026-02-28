local function f(ls, n)
    local answer = 0
    local result = {}
    for _, i in ipairs(ls) do
        if i[1] == n then
            result = i
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{1, 9, 4}, {83, 0, 5}, {9, 6, 100}}, 1), {1, 9, 4})
end

os.exit(lu.LuaUnit.run())
