local function f(pattern, items)
    local result = {}
    for i, text in ipairs(items) do
        local pos = text:match(".*()" .. pattern)
        if pos then
            table.insert(result, pos - 1)
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(' B ', {' bBb ', ' BaB ', ' bB', ' bBbB ', ' bbb'}), {})
end

os.exit(lu.LuaUnit.run())
