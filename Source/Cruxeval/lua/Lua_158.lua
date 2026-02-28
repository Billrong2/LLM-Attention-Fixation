local function f(arr)
    local n = {}
    for i, item in ipairs(arr) do
        if item % 2 == 0 then
            table.insert(n, item)
        end
    end
    local m = {}
    for i, item in ipairs(n) do
        table.insert(m, item)
    end
    for i, item in ipairs(arr) do
        table.insert(m, item)
    end
    local j = #n+1
    while j <= #m do
        if m[j] % 2 ~= 0 then
            table.remove(m, j)
        else
            j = j + 1
        end
    end
    return m
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({3, 6, 4, -2, 5}), {6, 4, -2, 6, 4, -2})
end

os.exit(lu.LuaUnit.run())
