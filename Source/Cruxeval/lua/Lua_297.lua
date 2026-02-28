local function f(num)
    if num > 0 and num < 1000 and num ~= 6174 then
        return 'Half Life'
    end
    return 'Not found'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(6173), 'Not found')
end

os.exit(lu.LuaUnit.run())
