local function f(s)
    s = string.gsub(s, '"', '')
    local lst = {}
    for i = 1, #s do
        lst[i] = string.sub(s, i, i)
    end
    local col = 1
    local count = 1
    while col <= #lst and (lst[col] == "." or lst[col] == ":" or lst[col] == ",") do
        if lst[col] == "." then
            count = count + 1
        end
        col = col + 1
    end
    return string.sub(s, col + count)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('"Makers of a Statement"'), 'akers of a Statement')
end

os.exit(lu.LuaUnit.run())
