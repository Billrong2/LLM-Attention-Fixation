local function f(text)
    local occ = {}
    local name = {a = 'b', b = 'c', c = 'd', d = 'e', e = 'f'}
    for i = 1, #text do
        local ch = string.sub(text, i, i)
        local mapped = name[ch] or ch
        occ[mapped] = (occ[mapped] or 0) + 1
    end
    
    local result = {}
    for _, x in pairs(occ) do
        table.insert(result, x)
    end
    
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('URW rNB'), {1, 1, 1, 1, 1, 1, 1})
end

os.exit(lu.LuaUnit.run())
