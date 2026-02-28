local function f(a, split_on)
    local t = {}
    for word in string.gmatch(a, "%S+") do
        for i = 1, #word do
            table.insert(t, word:sub(i, i))
        end
    end
    if string.find(table.concat(t), split_on) then
        return true
    else
        return false
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('booty boot-boot bootclass', 'k'), false)
end

os.exit(lu.LuaUnit.run())
