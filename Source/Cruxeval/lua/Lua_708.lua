local function f(string)
    local l = {}
    for i=1,string.len(string) do
        table.insert(l, string.sub(string,i,i))
    end
    for i=#l,1,-1 do
        if l[i] ~= ' ' then
            break
        end
        table.remove(l, i)
    end
    return table.concat(l)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('    jcmfxv     '), '    jcmfxv')
end

os.exit(lu.LuaUnit.run())
