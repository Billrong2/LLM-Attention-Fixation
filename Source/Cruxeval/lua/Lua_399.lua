local function f(text, old, new)
    if string.len(old) > 3 then
        return text
    end
    if string.find(text, old) and not string.find(text, ' ') then
        return string.gsub(text, old, new:rep(string.len(old)))
    end
    while string.find(text, old) do
        text = string.gsub(text, old, new)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('avacado', 'va', '-'), 'a--cado')
end

os.exit(lu.LuaUnit.run())
