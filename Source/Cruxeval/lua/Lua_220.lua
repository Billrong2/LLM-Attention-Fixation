local function f(text, m, n)
    text = text .. string.sub(text, 1, m) .. string.sub(text, n+1)
    local result = ""
    for i = n+1, #text-m do
        result = text:sub(i, i) .. result
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abcdefgabc', 1, 2), 'bagfedcacbagfedc')
end

os.exit(lu.LuaUnit.run())
