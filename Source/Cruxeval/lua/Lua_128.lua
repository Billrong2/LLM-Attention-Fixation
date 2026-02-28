local function f(text)
    local odd = ''
    local even = ''
    for i = 1, #text do
        local c = text:sub(i, i)
        if (i - 1) % 2 == 0 then
            even = even .. c
        else
            odd = odd .. c
        end
    end
    return even .. odd:lower()
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Mammoth'), 'Mmohamt')
end

os.exit(lu.LuaUnit.run())
