local function f(st)
    if string.sub(st, 1, 1) == '~' then
        local e = string.rep('s', 10 - string.len(st)) .. st
        return f(e)
    else
        return string.rep('n', 10 - string.len(st)) .. st
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('eqe-;ew22'), 'neqe-;ew22')
end

os.exit(lu.LuaUnit.run())
