local function f(r, w)
    local a = {}
    if string.sub(r, 1, 1) == string.sub(w, 1, 1) and string.sub(w, -1) == string.sub(r, -1) then
        table.insert(a, r)
        table.insert(a, w)
    else
        table.insert(a, w)
        table.insert(a, r)
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ab', 'xy'), {'xy', 'ab'})
end

os.exit(lu.LuaUnit.run())
