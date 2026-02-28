local function f(string, encryption)
    if encryption == 0 then
        return string
    else
        return string:upper():gsub('%a', function(c)
            local offset = c:find('%u') and 65 or 97
            return string.char((c:byte() - offset + encryption) % 26 + offset)
        end)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('UppEr', 0), 'UppEr')
end

os.exit(lu.LuaUnit.run())
