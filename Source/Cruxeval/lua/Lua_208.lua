local function f(items)
    local result = {}
    for i, item in ipairs(items) do
        for j = 1, #item do
            local d = item:sub(j, j)
            if not tonumber(d) then
                table.insert(result, d)
            end
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'123', 'cat', 'd dee'}), {'c', 'a', 't', 'd', ' ', 'd', 'e', 'e'})
end

os.exit(lu.LuaUnit.run())
