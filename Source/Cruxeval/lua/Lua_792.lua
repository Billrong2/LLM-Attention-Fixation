function f(l1, l2)
    if #l1 ~= #l2 then
        return {}
    end
    local result = {}
    for i = 1, #l1 do
        result[l1[i]] = l2
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'a', 'b'}, {'car', 'dog'}), {['a'] = {'car', 'dog'}, ['b'] = {'car', 'dog'}})
end

os.exit(lu.LuaUnit.run())
