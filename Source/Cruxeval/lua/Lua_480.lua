local function f(s, c1, c2)
    if s == '' then
        return s
    end
    local ls = {}
    for token in string.gmatch(s, "[^" .. c1 .. "]+") do
        if string.find(token, c1, 1, true) then
            table.insert(ls, string.gsub(token, c1, c2, 1))
        else
            table.insert(ls, token)
        end
    end
    return table.concat(ls, c1)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('', 'mi', 'siast'), '')
end

os.exit(lu.LuaUnit.run())
