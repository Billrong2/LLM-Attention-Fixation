local function f(text, res)
    local result = text:gsub("[%*\"\n]", "!" .. tostring(res))
    if result:sub(1, 1) == "!" then
        result = result:sub(#tostring(res) + 1)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('"Leap and the net will appear', 123), '3Leap and the net will appear')
end

os.exit(lu.LuaUnit.run())
