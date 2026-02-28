local function f(char_map, text)
    local new_text = ''
    for i = 1, #text do
        local ch = text:sub(i, i)
        local val = char_map[ch]
        if val == nil then
            new_text = new_text .. ch
        else
            new_text = new_text .. val
        end
    end
    return new_text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, 'hbd'), 'hbd')
end

os.exit(lu.LuaUnit.run())
