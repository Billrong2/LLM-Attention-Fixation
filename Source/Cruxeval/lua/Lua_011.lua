local function f(a, b)
    for key, value in pairs(b) do
        if not a[key] then
            a[key] = {value}
        else
            table.insert(a[key], value)
        end
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, {['foo'] = 'bar'}), {['foo'] = {'bar'}})
end

os.exit(lu.LuaUnit.run())
