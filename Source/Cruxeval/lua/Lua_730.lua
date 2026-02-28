local function f(text)
    local m = 0
    local cnt = 0
    for i in text:gmatch("%S+") do
        if #i > m then
            cnt = cnt + 1
            m = #i
        end
    end
    return cnt
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl'), 2)
end

os.exit(lu.LuaUnit.run())
