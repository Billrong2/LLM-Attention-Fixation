local function f(string)
    if string:match("^[%w]+$") then
        return "ascii encoded is allowed for this language"
    end
    return "more than ASCII"
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Str zahrnuje anglo-ameriæske vasi piscina and kuca!'), 'more than ASCII')
end

os.exit(lu.LuaUnit.run())
