local function f(bag)
    local values = {}
    for _, value in pairs(bag) do
        table.insert(values, value)
    end

    local tbl = {}
    for v = 0, 99 do
        if table.concat(values):find(tostring(v)) then
            tbl[v] = #values
        end
    end

    return tbl
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0}), {[0] = 5})
end

os.exit(lu.LuaUnit.run())
