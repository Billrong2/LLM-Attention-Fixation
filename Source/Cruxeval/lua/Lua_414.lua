local function f(d)
    local dCopy = {}
    for key, value in pairs(d) do
        local newValue = {}
        for i = 1, #value do
            table.insert(newValue, string.upper(value[i]))
        end
        dCopy[key] = newValue
    end
    return dCopy
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['X'] = {'x', 'y'}}), {['X'] = {'X', 'Y'}})
end

os.exit(lu.LuaUnit.run())
