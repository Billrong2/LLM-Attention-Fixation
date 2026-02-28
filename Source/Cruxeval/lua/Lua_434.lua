local function f(string)
    local index = 0
    for i = 1, string.len(string) do
        if string.sub(string, i, i) == 'e' then
            index = i
        end
    end
    if index > 0 then
        return index - 1
    else
        return "Nuk"
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('eeuseeeoehasa'), 8)
end

os.exit(lu.LuaUnit.run())
