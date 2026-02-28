local function f(array, L)
    if L <= 0 then
        return array
    end
    if #array < L then
        local temp = f(array, L - #array)
        for i = 1, #temp do
            table.insert(array, temp[i])
        end
    end
    return array
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3}, 4), {1, 2, 3, 1, 2, 3})
end

os.exit(lu.LuaUnit.run())
