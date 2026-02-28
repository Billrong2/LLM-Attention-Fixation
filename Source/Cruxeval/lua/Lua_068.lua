local function f(text, pref)
    if string.sub(text, 1, string.len(pref)) == pref then
        local n = string.len(pref) + 1
        local text_split = {}
        for token in string.gmatch(text, '[^%.]+') do
            table.insert(text_split, token)
        end
        text = table.concat(text_split, '.', 2, #text_split)
    end
    return text
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('omeunhwpvr.dq', 'omeunh'), 'dq')
end

os.exit(lu.LuaUnit.run())
