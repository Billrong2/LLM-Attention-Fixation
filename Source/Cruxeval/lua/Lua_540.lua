local function f(a)
    local b = {}
    for i=1, #a do
        b[i] = a[i]
    end
    
    for k=1, #a-1, 2 do
        table.insert(b, k+1, b[k])
    end
    table.insert(b, b[1])
    
    return b
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({5, 5, 5, 6, 4, 9}), {5, 5, 5, 5, 5, 5, 6, 4, 9, 5})
end

os.exit(lu.LuaUnit.run())
