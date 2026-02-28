local function f(text)
    local ls = {}
    for i = #text, 1, -1 do
        table.insert(ls, string.sub(text, i, i))
    end
    local text2 = ''
    for i = 3, #ls, 3 do
        local part = ''
        for j = i, i + 2 do
            part = part .. '---' .. ls[j]
        end
        text2 = text2 .. string.sub(part, 4) .. '---'
    end
    return string.sub(text2, 1, -4)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('scala'), 'a---c---s')
end

os.exit(lu.LuaUnit.run())
