local function f(text)
    local ls = {}
    for i=1, string.len(text) do
        table.insert(ls, string.sub(text,i,i))
    end
    local total = (#ls - 1) * 2
    for i = 1, total do
        if i % 2 == 1 then
            table.insert(ls, #ls + 1, '+')
        else
            table.insert(ls, 1, '+')
        end
    end
    return table.concat(ls)
end

function rjust(s, width)
    local padding = string.rep(' ', width - string.len(s))
    return padding .. s
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('taole'), '++++taole++++')
end

os.exit(lu.LuaUnit.run())
