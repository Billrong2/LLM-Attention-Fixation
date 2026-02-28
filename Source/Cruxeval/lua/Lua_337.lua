local function f(txt)
    local d = {}
    for i = 1, string.len(txt) do
        local c = string.sub(txt, i, i)
        if tonumber(c) then
            goto continue
        end
        if string.match(c, '[a-z]') then
            table.insert(d, string.upper(c))
        elseif string.match(c, '[A-Z]') then
            table.insert(d, string.lower(c))
        end
        ::continue::
    end
    return table.concat(d)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('5ll6'), 'LL')
end

os.exit(lu.LuaUnit.run())
