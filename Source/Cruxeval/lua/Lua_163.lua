local function f(text, space_symbol, size)
    local spaces = string.rep(space_symbol, size - string.len(text))
    return text .. spaces
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('w', '))', 7), 'w))))))))))))')
end

os.exit(lu.LuaUnit.run())
