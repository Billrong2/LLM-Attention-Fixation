local function f(d)
    local key1 = nil
    local val1 = nil
    for k, v in pairs(d) do
        if key1 == nil or k > key1 then
            key1 = k
            val1 = v
        end
    end
    d[key1] = nil

    local key2 = nil
    local val2 = nil
    for k, v in pairs(d) do
        if key2 == nil or k > key2 then
            key2 = k
            val2 = v
        end
    end
    d[key2] = nil

    return { [key1] = val1, [key2] = val2 }
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[2] = 3, [17] = 3, [16] = 6, [18] = 6, [87] = 7}), {[87] = 7, [18] = 6})
end

os.exit(lu.LuaUnit.run())
