local function f(ans)
    if string.match(ans, "%d+") then
        local total = tonumber(ans) * 4 - 50
        local count = 0
        for i=1, #ans do
            local c = ans:sub(i, i)
            if not string.match(c, '[02468]') then
                count = count + 1
            end
        end
        total = total - count * 100
        return total
    end
    return 'NAN'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('0'), -50)
end

os.exit(lu.LuaUnit.run())
