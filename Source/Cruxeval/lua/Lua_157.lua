local function f(phrase)
    local ans = 0
    local words = {}
    for word in string.gmatch(phrase, "%S+") do
        for i = 1, #word do
            if word:sub(i, i) == "0" then
                ans = ans + 1
            end
        end
    end
    return ans
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('aboba 212 has 0 digits'), 1)
end

os.exit(lu.LuaUnit.run())
