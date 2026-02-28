local function f(array, elem)
    local result = {}
    for k, v in pairs(array) do
        result[k] = v
    end

    while next(result) ~= nil do
        local key, value = next(result)
        if elem == key or elem == value then
            for k, v in pairs(array) do
                result[k] = v
            end
        end
        result[key] = nil
    end

    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, 1), {})
end

os.exit(lu.LuaUnit.run())
