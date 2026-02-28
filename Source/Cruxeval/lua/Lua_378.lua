local function f(dic, key)
    local v = dic[key]
    if v == nil then
        return 'No such key!'
    end
    dic[key] = nil
    local k, v = next(dic)
    while k ~= nil do
       local new_key = v
       local new_value = k
       dic[k] = nil
       k, v = next(dic, k)
       dic[new_key] = new_value
    end
    return v
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['did'] = 0}, 'u'), 'No such key!')
end

os.exit(lu.LuaUnit.run())
