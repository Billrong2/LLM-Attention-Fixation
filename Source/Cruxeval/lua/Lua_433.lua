local function f(text)
    local text_split = {}
    for word in string.gmatch(text, "[^,]+") do
        table.insert(text_split, word)
    end
    
    table.remove(text_split, 1)
    local index = 1
    for i, v in ipairs(text_split) do
        if v == 'T' then
            index = i
            break
        end
    end
    table.insert(text_split, 1, table.remove(text_split, index))
    
    return 'T,' .. table.concat(text_split, ',')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Dmreh,Sspp,T,G ,.tB,Vxk,Cct'), 'T,T,Sspp,G ,.tB,Vxk,Cct')
end

os.exit(lu.LuaUnit.run())
