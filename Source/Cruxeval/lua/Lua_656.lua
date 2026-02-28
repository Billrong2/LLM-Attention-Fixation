local function f(letters)
    local a = {}
    for i = 1, #letters do
        if a[letters[i]] then
            return 'no'
        end
        a[letters[i]] = true
    end
    return 'yes'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'b', 'i', 'r', 'o', 's', 'j', 'v', 'p'}), 'yes')
end

os.exit(lu.LuaUnit.run())
