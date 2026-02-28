local function f(text)
    local result = ''
    local mid = math.floor((string.len(text) - 1) / 2)
    for i = 0, mid - 1 do
        result = result .. string.sub(text, i + 1, i + 1)
    end
    for i = mid, string.len(text) - 2 do
        result = result .. string.sub(text, mid + string.len(text) - i, mid + string.len(text) - i)
    end
    result = result .. string.rep(string.sub(text, -1), string.len(text) - string.len(result))
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('eat!'), 'e!t!')
end

os.exit(lu.LuaUnit.run())
