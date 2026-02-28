local function f(vectors)
    local sorted_vecs = {}
    for i, vec in ipairs(vectors) do
        table.sort(vec)
        table.insert(sorted_vecs, vec)
    end
    return sorted_vecs
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())
