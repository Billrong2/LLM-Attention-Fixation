local function f(numbers)
    for i = 1, string.len(numbers) do
        if string.gsub(numbers, '3', ''):len() < string.len(numbers) - 1 then
            return i
        end
    end
    return -1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('23157'), -1)
end

os.exit(lu.LuaUnit.run())
