local function f(text, new_ending)
    local result = {}
    for i=1, #text do
        table.insert(result, text:sub(i, i))
    end
    for i=1, #new_ending do
        table.insert(result, new_ending:sub(i, i))
    end
    return table.concat(result)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('jro', 'wdlp'), 'jrowdlp')
end

os.exit(lu.LuaUnit.run())
