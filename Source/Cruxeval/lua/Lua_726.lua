local function f(text)
    local ws = 0
    for i = 1, #text do
        local s = text:sub(i, i)
        if s:match("%s") then
            ws = ws + 1
        end
    end
    return {ws, #text}
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('jcle oq wsnibktxpiozyxmopqkfnrfjds'), {2, 34})
end

os.exit(lu.LuaUnit.run())
