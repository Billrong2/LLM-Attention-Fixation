local function f(text, elem)
    if elem ~= '' then
        while text:sub(1, #elem) == elem do
            text = text:gsub(elem, '')
        end
        while elem:sub(1, #text) == text do
            elem = elem:gsub(text, '')
        end
    end
    return {elem, text}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('some', '1'), {'1', 'some'})
end

os.exit(lu.LuaUnit.run())
