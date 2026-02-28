local function f(text, char1, char2)
    local t1a = {}
    local t2a = {}
    for i = 1, #char1 do
        table.insert(t1a, char1:sub(i, i))
        table.insert(t2a, char2:sub(i, i))
    end
    local t1 = {}
    for i = 1, #t1a do
        t1[t1a[i]] = t2a[i]
    end
    return text:gsub(".", t1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ewriyat emf rwto segya', 'tey', 'dgo'), 'gwrioad gmf rwdo sggoa')
end

os.exit(lu.LuaUnit.run())
