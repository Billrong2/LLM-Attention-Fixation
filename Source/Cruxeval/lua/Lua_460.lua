local function f(text, amount)
    local length = string.len(text)
    local pre_text = '|'
    if amount >= length then
        local extra_space = amount - length
        pre_text = pre_text .. string.rep(' ', math.floor(extra_space / 2))
        return pre_text .. text .. pre_text
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('GENERAL NAGOOR', 5), 'GENERAL NAGOOR')
end

os.exit(lu.LuaUnit.run())
