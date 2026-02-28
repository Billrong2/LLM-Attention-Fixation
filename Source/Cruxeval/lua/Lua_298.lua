local function f(text)
    local new_text = {}
    for i = 1, #text do
        local character = text:sub(i, i)
        local new_character = string.upper(character)
        if character == new_character then
            new_character = string.lower(character)
        else
            new_character = string.upper(character)
        end
        table.insert(new_text, new_character)
    end
    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dst vavf n dmv dfvm gamcu dgcvb.'), 'DST VAVF N DMV DFVM GAMCU DGCVB.')
end

os.exit(lu.LuaUnit.run())
