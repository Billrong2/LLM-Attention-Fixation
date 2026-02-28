local function f(dictionary, key)
    dictionary[key] = nil
    local min_key = nil
    local min_value = math.huge
    for k, v in pairs(dictionary) do
        if v < min_value then
            min_key = k
            min_value = v
        end
    end
    if min_key == key then
        key = next(dictionary)
    end
    return key
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['Iron Man'] = 4, ['Captain America'] = 3, ['Black Panther'] = 0, ['Thor'] = 1, ['Ant-Man'] = 6}, 'Iron Man'), 'Iron Man')
end

os.exit(lu.LuaUnit.run())
