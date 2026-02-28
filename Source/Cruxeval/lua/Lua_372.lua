local function f(list_, num)
    local temp = {}
    for i = 1, #list_ do
        local element = list_[i]
        element = string.rep(element .. ",", num // 2)
        table.insert(temp, element)
    end
    return temp
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'v'}, 1), {''})
end

os.exit(lu.LuaUnit.run())
