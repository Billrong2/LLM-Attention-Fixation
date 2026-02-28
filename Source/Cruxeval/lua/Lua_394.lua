local function f(text)
    local k = {}
    for str in text:gmatch("[^\n]*") do
        table.insert(k, str)
    end
    local i = 0
    for _, j in ipairs(k) do
        if #j == 0 then
            return i
        end
        i = i + 1
    end
    return -1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('2 m2 \n\nbike'), 1)
end

os.exit(lu.LuaUnit.run())
