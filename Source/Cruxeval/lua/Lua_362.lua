local function f(text)
    for i = 1, #text-1 do
        if text:sub(i):lower() == text:sub(i) then
            return text:sub(i + 1)
        end
    end
    return ''
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('wrazugizoernmgzu'), 'razugizoernmgzu')
end

os.exit(lu.LuaUnit.run())
