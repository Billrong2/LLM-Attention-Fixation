local function f(text)
    local valid_chars = {'-', '_', '+', '.', '/', ' '}
    text = text:upper()
    for i = 1, #text do
        local char = text:sub(i, i)
        if not char:match('%w') and not table.concat(valid_chars):find(char, 1, true) then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW'), false)
end

os.exit(lu.LuaUnit.run())
