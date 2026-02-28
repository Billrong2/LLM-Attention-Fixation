local function f(forest, animal)
    local index = string.find(forest, animal, 1, true)
    local result = {string.byte(forest, 1, #forest)}
    while index < #forest do
        result[index] = string.byte(forest, index + 1)
        index = index + 1
    end
    if index == #forest then
        result[index] = string.byte('-')
    end
    return string.char(table.unpack(result))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('2imo 12 tfiqr.', 'm'), '2io 12 tfiqr.-')
end

os.exit(lu.LuaUnit.run())
