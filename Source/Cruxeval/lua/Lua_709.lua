local function f(text)
    local my_list = {}
    for word in text:gmatch("%S+") do
        table.insert(my_list, word)
    end
    table.sort(my_list, function(a, b) return a > b end)
    return table.concat(my_list, " ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a loved'), 'loved a')
end

os.exit(lu.LuaUnit.run())
