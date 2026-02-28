local function f(dictionary)
    local new_dict = {}
    for k, v in pairs(dictionary) do
        new_dict[k] = v
    end
    return new_dict
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[563] = 555, [133] = None}), {[563] = 555, [133] = None})
end

os.exit(lu.LuaUnit.run())
