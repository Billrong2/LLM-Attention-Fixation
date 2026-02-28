local function f(text, substr, occ)
    local n = 0
    while true do
        local i = text:find(substr:reverse(), 1, true)
        if i == nil then
            break
        elseif n == occ then
            return #text - i - #substr + 1
        else
            n = n + 1
            text = text:sub(1, i - 1)
        end
    end
    return -1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('zjegiymjc', 'j', 2), -1)
end

os.exit(lu.LuaUnit.run())
