local function f(array)
    local just_ns = {}
    for i, num in ipairs(array) do
        table.insert(just_ns, string.rep('n', num))
    end
    
    local final_output = {}
    for _, wipe in ipairs(just_ns) do
        table.insert(final_output, wipe)
    end
    
    return final_output
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())
