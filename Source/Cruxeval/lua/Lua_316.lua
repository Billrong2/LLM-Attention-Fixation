local function f(name)
    local split_name = {}
    for word in string.gmatch(name, "%S+") do
        table.insert(split_name, word)
    end
    return '| ' .. table.concat(split_name, ' ') .. ' |'
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('i am your father'), '| i am your father |')
end

os.exit(lu.LuaUnit.run())
