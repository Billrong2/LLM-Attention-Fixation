local function f(d)
    local r = {}
    while next(d) ~= nil do
        for k, v in pairs(d) do
            r[k] = v
        end
        local max_key = 0
        for k, _ in pairs(d) do
            if k > max_key then
                max_key = k
            end
        end
        d[max_key] = nil
    end
    return r
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[3] = 'A3', [1] = 'A1', [2] = 'A2'}), {[3] = 'A3', [1] = 'A1', [2] = 'A2'})
end

os.exit(lu.LuaUnit.run())
