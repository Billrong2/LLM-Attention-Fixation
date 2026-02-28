function f(dic)
    local d = {}
    for key, value in pairs(dic) do
        local k, v = next(dic)
        dic[k] = nil
        d[key] = v
    end
    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())
