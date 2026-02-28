local function f(text)
    local new_text = {}
    for character in text:gmatch"." do
        if character:match("%u") then
            table.insert(new_text, math.floor(#new_text / 2) + 1, character)
        end
    end
    if #new_text == 0 then
        new_text = {'-'}
    end
    return table.concat(new_text)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('String matching is a big part of RexEx library.'), 'RES')
end

os.exit(lu.LuaUnit.run())
