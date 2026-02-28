local string = require("string")

local function f(text)
    if text and text:upper() == text then
        local cs = string.maketrans(string.uppercase, string.lowercase)
        return text:gsub(".", function(c)
            return cs[c] or c
        end)
    end
    return string.sub(text:lower(), 1, 3)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n'), 'mty')
end

os.exit(lu.LuaUnit.run())
