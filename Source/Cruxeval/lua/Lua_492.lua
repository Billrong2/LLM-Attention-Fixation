local function f(text, value)
    local ls = {}
    for i = 1, #text do
        table.insert(ls, text:sub(i, i))
    end
    
    if (#ls - select(2, text:gsub(value, ""))) % 2 == 0 then
        while table.concat(ls):find(value) do
            table.remove(ls, table.concat(ls):find(value))
        end
    else
        ls = {}
    end
    
    return table.concat(ls)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abbkebaniuwurzvr', 'm'), 'abbkebaniuwurzvr')
end

os.exit(lu.LuaUnit.run())
