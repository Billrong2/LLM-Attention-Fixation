local function f(text)
    local new_text = {}
    for i = 1, #text do
        local c = text:sub(i, i)
        if tonumber(c) then
            table.insert(new_text, c)
        else
            table.insert(new_text, '*')
        end
    end
    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('5f83u23saa'), '5*83*23***')
end

os.exit(lu.LuaUnit.run())
