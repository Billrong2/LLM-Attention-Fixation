local function f(text, wrong, right)
    local new_text = string.gsub(text, wrong, right)
    return string.upper(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('zn kgd jw lnt', 'h', 'u'), 'ZN KGD JW LNT')
end

os.exit(lu.LuaUnit.run())
