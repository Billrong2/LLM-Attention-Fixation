local function f(text, comparison)
    local length = string.len(comparison)
    if length <= string.len(text) then
        for i = 1, length do
            if string.sub(comparison, length - i + 1, length - i + 1) ~= string.sub(text, string.len(text) - i + 1, string.len(text) - i + 1) then
                return i
            end
        end
    end
    return length
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('managed', ''), 0)
end

os.exit(lu.LuaUnit.run())
