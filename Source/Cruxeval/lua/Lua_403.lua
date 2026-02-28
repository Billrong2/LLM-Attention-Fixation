local function f(full, part)
    local length = string.len(part)
    local index = string.find(full, part)
    local count = 0
    while index do
        full = string.sub(full, index + length)
        index = string.find(full, part)
        count = count + 1
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('hrsiajiajieihruejfhbrisvlmmy', 'hr'), 2)
end

os.exit(lu.LuaUnit.run())
