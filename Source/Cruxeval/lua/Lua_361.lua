local function f(text)
    local splitted = {}
    for str in string.gmatch(text, '[^:]+') do
        table.insert(splitted, str)
    end
    local first_part = splitted[1]
    local count = 0
    for i = 1, #first_part do
        local c = string.sub(first_part, i, i)
        if c == '#' then
            count = count + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('#! : #!'), 1)
end

os.exit(lu.LuaUnit.run())
