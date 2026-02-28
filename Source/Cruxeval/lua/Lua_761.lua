local function f(array)
    local output = {}
    for i, value in ipairs(array) do
        table.insert(output, value)
    end
    for i = 1, #output, 2 do
        output[i] = output[#output - i + 1]
    end
    local reversed_output = {}
    for i = #output, 1, -1 do
        table.insert(reversed_output, output[i])
    end
    return reversed_output
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())
