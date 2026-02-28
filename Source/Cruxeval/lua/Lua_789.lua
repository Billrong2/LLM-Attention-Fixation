local function f(text, n)
    if n < 0 or string.len(text) <= n then
        return text
    end
    local result = string.sub(text, 1, n)
    local i = string.len(result) - 1
    while i >= 0 do
        if string.sub(result, i + 1, i + 1) ~= string.sub(text, i + 1, i + 1) then
            break
        end
        i = i - 1
    end
    return string.sub(text, 1, i + 1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('bR', -1), 'bR')
end

os.exit(lu.LuaUnit.run())
