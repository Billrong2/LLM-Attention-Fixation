local function f(arr)
    local count = #arr
    local sub = {}
    for i = 1, count do
        sub[i] = arr[i]
        if i % 2 == 1 then
            sub[i] = sub[i] * 5
        end
    end
    return sub
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({-3, -6, 2, 7}), {-15, -6, 10, 7})
end

os.exit(lu.LuaUnit.run())
