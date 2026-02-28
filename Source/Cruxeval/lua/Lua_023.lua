local function f(text, chars)
    if chars ~= "" then
        text = text:gsub("["..chars.."]+$", "")
    else
        text = text:gsub("%s+$", "")
    end
    if text == "" then
        return "-"
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('new-medium-performing-application - XQuery 2.2', '0123456789-'), 'new-medium-performing-application - XQuery 2.')
end

os.exit(lu.LuaUnit.run())
