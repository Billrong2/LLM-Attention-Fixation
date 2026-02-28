local function f(array)
    local return_arr = {}
    for _, a in ipairs(array) do
        table.insert(return_arr, {table.unpack(a)})
    end
    return return_arr
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{1, 2, 3}, {}, {1, 2, 3}}), {{1, 2, 3}, {}, {1, 2, 3}})
end

os.exit(lu.LuaUnit.run())
