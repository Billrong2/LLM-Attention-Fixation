function f(s, n)
    local out = {}
    local ls = {}
    for word in string.gmatch(s, "%S+") do
        table.insert(ls, word)
    end
    
    while #ls >= n do
        for i = #ls-n+1, #ls do
            table.insert(out, ls[i])
        end
        for i = 1, n do
            table.remove(ls, #ls)
        end
    end
    
    local combined = table.concat(out, "_")
    table.insert(ls, combined)
    
    return ls
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('one two three four five', 3), {'one', 'two', 'three_four_five'})
end

os.exit(lu.LuaUnit.run())
