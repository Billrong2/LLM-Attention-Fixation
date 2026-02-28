function f(values, value)
    local length = #values
    local new_dict = {}
    for i = 1, length do
        new_dict[values[i]] = value
    end
    new_dict[table.concat(values)] = value * 3
    return new_dict
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'0', '3'}, 117), {['0'] = 117, ['3'] = 117, ['03'] = 351})
end

os.exit(lu.LuaUnit.run())
