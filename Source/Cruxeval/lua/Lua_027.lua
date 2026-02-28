local function f(w)
    local ls = {}
    for i = 1, string.len(w) do
        table.insert(ls, string.sub(w, i, i))
    end
    local omw = ''
    while #ls > 0 do
        omw = omw .. table.remove(ls, 1)
        if #ls * 2 > string.len(w) then
            if string.sub(w, #ls + 1) == omw then
                return true
            end
        end
    end
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('flak'), false)
end

os.exit(lu.LuaUnit.run())
