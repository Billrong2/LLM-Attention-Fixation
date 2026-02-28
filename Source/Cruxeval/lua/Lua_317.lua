local function f(text, a, b)
    text = string.gsub(text, a, b)
    return string.gsub(text, b, a)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(' vup a zwwo oihee amuwuuw! ', 'a', 'u'), ' vap a zwwo oihee amawaaw! ')
end

os.exit(lu.LuaUnit.run())
