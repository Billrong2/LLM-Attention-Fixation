local function f(text)
    local pos = string.find(text, ",")
    if pos then
        return pos - 1
    else
        return -1
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('There are, no, commas, in this text'), 9)
end

os.exit(lu.LuaUnit.run())
