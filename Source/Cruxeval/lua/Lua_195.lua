local function f(text)
    local prefixes = {'acs', 'asp', 'scn'}
    for i = 1, #prefixes do
        text = text:gsub('^' .. prefixes[i], '') .. ' '
    end
    return text:gsub('^ ', ''):sub(1, -2)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ilfdoirwirmtoibsac'), 'ilfdoirwirmtoibsac  ')
end

os.exit(lu.LuaUnit.run())
