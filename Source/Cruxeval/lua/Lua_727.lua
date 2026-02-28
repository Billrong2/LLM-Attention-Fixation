local function f(numbers, prefix)
    local result = {}
    for _, n in ipairs(numbers) do
        if string.sub(n, 1, #prefix) == prefix then
            table.insert(result, string.sub(n, #prefix + 1))
        else
            table.insert(result, n)
        end
    end
    table.sort(result)
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'ix', 'dxh', 'snegi', 'wiubvu'}, ''), {'dxh', 'ix', 'snegi', 'wiubvu'})
end

os.exit(lu.LuaUnit.run())
