local function f(text, letter)
    if string.find(text, letter) then
        local start = string.find(text, letter)
        return string.sub(text, start + 1) .. string.sub(text, 1, start)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('19kefp7', '9'), 'kefp719')
end

os.exit(lu.LuaUnit.run())
