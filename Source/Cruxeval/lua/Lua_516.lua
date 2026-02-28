local function f(strings, substr)
    local list = {}
    for i, s in ipairs(strings) do
        if string.sub(s, 1, string.len(substr)) == substr then
            table.insert(list, s)
        end
    end
    table.sort(list, function(a, b) return string.len(a) < string.len(b) end)
    return list
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'condor', 'eyes', 'gay', 'isa'}, 'd'), {})
end

os.exit(lu.LuaUnit.run())
