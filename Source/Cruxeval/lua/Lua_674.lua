local function f(text)
    local ls = {text:byte(1, -1)}
    for x = #ls, 1, -1 do
        if #ls <= 1 then break end
        if not string.match(string.char(ls[x]), "[zyxwvutsrqponmlkjihgfedcba]") then
            table.remove(ls, x)
        end
    end
    return string.char(table.unpack(ls))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qq'), 'qq')
end

os.exit(lu.LuaUnit.run())
