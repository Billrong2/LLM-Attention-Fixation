local function f(no)
    local d = {}
    for i = 1, #no do
        d[no[i]] = false
    end
    
    local count = 0
    for _ in pairs(d) do
        count = count + 1
    end
    
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'l', 'f', 'h', 'g', 's', 'b'}), 6)
end

os.exit(lu.LuaUnit.run())
