local function f(tokens)
    tokens = string.gmatch(tokens, "%S+")
    local token1 = tokens()
    local token2 = tokens()
    if not token2 then
        return token1
    end
    return string.format("%-5s %-5s", token2, token1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('gsd avdropj'), 'avdropj gsd  ')
end

os.exit(lu.LuaUnit.run())
