local function f(text)
    local t = 5
    local tab = {}
    for i = 1, #text do
        local char = text:sub(i, i)
        if string.find("aeiouy", char:lower(), 1, true) then
            table.insert(tab, string.upper(char):rep(t))
        else
            table.insert(tab, char:rep(t))
        end
    end
    return table.concat(tab, ' ')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('csharp'), 'ccccc sssss hhhhh AAAAA rrrrr ppppp')
end

os.exit(lu.LuaUnit.run())
