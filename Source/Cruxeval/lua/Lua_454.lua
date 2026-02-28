local function f(d, count)
    local new_dict = {}
    for i=1, count do
        local temp_dict = {}
        for k, v in pairs(d) do
            temp_dict[k] = v
        end
        for k, v in pairs(new_dict) do
            temp_dict[k] = v
        end
        new_dict = temp_dict
    end
    return new_dict
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['a'] = 2, ['b'] = {}, ['c'] = {}}, 0), {})
end

os.exit(lu.LuaUnit.run())
