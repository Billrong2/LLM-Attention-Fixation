local function f(text)
    if text == '' then
        return false
    end
    local first_char = text:sub(1, 1)
    if tonumber(text:sub(1, 1)) then
        return false
    end
    for last_char in text:gmatch(".") do
        if last_char ~= '_' and not last_char:match("[%w_]") then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('meet'), true)
end

os.exit(lu.LuaUnit.run())
