local function f(text)
    for i = #text, 1, -1 do
        if string.byte(text, i) < 65 or string.byte(text, i) > 90 then
            return string.sub(text, 1, i-1)
        end
    end
    return ''
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('SzHjifnzog'), 'SzHjifnzo')
end

os.exit(lu.LuaUnit.run())
