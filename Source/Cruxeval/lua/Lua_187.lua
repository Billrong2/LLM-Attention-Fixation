local function f(d, index)
    local length = 0
    for _, _ in pairs(d) do
        length = length + 1
    end
    local idx = index % length
    local v = nil
    for k, value in pairs(d) do
        v = value
        d[k] = nil
        idx = idx - 1
        if idx == 0 then
            break
        end
    end
    return v
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[27] = 39}, 1), 39)
end

os.exit(lu.LuaUnit.run())
