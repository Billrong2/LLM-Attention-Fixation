local function f(text, chars)
    local chars_list = {}
    for i = 1, string.len(chars) do
        table.insert(chars_list, string.sub(chars, i, i))
    end
    
    local text_list = {}
    for i = 1, string.len(text) do
        table.insert(text_list, string.sub(text, i, i))
    end
    
    local new_text = text_list
    while #new_text > 0 do
        local found = false
        for i, v in ipairs(chars_list) do
            if new_text[1] == v then
                found = true
                break
            end
        end
        if found then
            table.remove(new_text, 1)
        else
            break
        end
    end
    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('asfdellos', 'Ta'), 'sfdellos')
end

os.exit(lu.LuaUnit.run())
