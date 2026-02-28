local function f(text)
    for i=1, #text do
        if text:sub(i, i) == ' ' then
            text = text:gsub('^%s*', '')
        else
            text = text:gsub('cd', text:sub(i, i))
        end
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('lorem ipsum'), 'lorem ipsum')
end

os.exit(lu.LuaUnit.run())
