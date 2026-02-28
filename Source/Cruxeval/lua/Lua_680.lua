local function f(text)
    local letters = ''
    for i = 1, string.len(text) do
        if string.match(text:sub(i, i), "%w") then
            letters = letters .. text:sub(i, i)
        end
    end
    return letters
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('we@32r71g72ug94=(823658*!@324'), 'we32r71g72ug94823658324')
end

os.exit(lu.LuaUnit.run())
