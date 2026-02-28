local function f(line, equalityMap)
    local rs = {}
    for i, v in ipairs(equalityMap) do
        rs[v[1]] = v[2]
    end
    return string.gsub(line, ".", rs)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abab', {{'a', 'b'}, {'b', 'a'}}), 'baba')
end

os.exit(lu.LuaUnit.run())
