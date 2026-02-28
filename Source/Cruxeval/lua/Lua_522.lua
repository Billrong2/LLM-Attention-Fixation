local function f(numbers)
    local floats = {}
    for _, n in ipairs(numbers) do
        table.insert(floats, n % 1)
    end
    if contains(floats, 1) then
        return floats
    else
        return {}
    end
end

function contains(t, val)
    for _, value in ipairs(t) do
        if value == val then
            return true
        end
    end
    return false
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119}), {})
end

os.exit(lu.LuaUnit.run())
