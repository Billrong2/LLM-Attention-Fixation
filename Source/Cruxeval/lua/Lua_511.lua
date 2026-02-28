local function f(fields, update_dict)
    local di = {}
    for i, field in ipairs(fields) do
        di[field] = ''
    end
    for key, value in pairs(update_dict) do
        di[key] = value
    end
    return di
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'ct', 'c', 'ca'}, {['ca'] = 'cx'}), {['ct'] = '', ['c'] = '', ['ca'] = 'cx'})
end

os.exit(lu.LuaUnit.run())
