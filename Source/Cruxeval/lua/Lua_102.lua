local function f(names, winners)
    local ls = {}
    for i, name in ipairs(names) do
        if winners[name] then
            table.insert(ls, i)
        end
    end
    table.sort(ls, function(a, b) return a > b end)
    return ls
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'e', 'f', 'j', 'x', 'r', 'k'}, {'a', 'v', '2', 'im', 'nb', 'vj', 'z'}), {})
end

os.exit(lu.LuaUnit.run())
