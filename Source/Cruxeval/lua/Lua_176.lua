local function f(text, to_place)
    local after_place = text:sub(1, text:find(to_place, 1, true))
    local before_place = text:sub(text:find(to_place, 1, true) + 1)
    return after_place .. before_place
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('some text', 'some'), 'some text')
end

os.exit(lu.LuaUnit.run())
