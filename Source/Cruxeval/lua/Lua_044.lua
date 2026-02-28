local function f(text)
    local ls = {}
    for i = 1, string.len(text) do
        table.insert(ls, string.sub(text, i, i))
    end
    for i = 1, #ls do
        if ls[i] ~= "+" then
            table.insert(ls, i, "+")
            table.insert(ls, i, "*")
            break
        end
    end
    return table.concat(ls, "+")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('nzoh'), '*+++n+z+o+h')
end

os.exit(lu.LuaUnit.run())
