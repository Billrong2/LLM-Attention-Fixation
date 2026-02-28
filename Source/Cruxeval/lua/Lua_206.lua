local function f(a)
    local result = {}
    for word in a:gmatch("%S+") do
        table.insert(result, word)
    end
    return table.concat(result, " ")
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(' h e l l o   w o r l d! '), 'h e l l o w o r l d!')
end

os.exit(lu.LuaUnit.run())
