local function f(text, char)
    local length = string.len(text)
    local index = -1
    local new_text = {}
    
    for i=1, length do
        if string.sub(text, i, i) == char then
            index = i
        end
    end
    
    if index == -1 then
        index = math.floor(length / 2)
    end
    
    for i=1, length do
        if i ~= index then
            table.insert(new_text, string.sub(text, i, i))
        end
    end
    
    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('o horseto', 'r'), 'o hoseto')
end

os.exit(lu.LuaUnit.run())
