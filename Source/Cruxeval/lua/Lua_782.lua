local function f(input)
    for i = 1, string.len(input) do
        if string.sub(input, i, i) == string.upper(string.sub(input, i, i)) then
            return false
        end
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a j c n x X k'), false)
end

os.exit(lu.LuaUnit.run())
