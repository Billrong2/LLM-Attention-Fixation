local function f(text, suffix)
    local output = text
    while string.sub(text, -string.len(suffix)) == suffix do
        output = string.sub(text, 1, -string.len(suffix) - 1)
        text = output
    end
    return output
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('!klcd!ma:ri', '!'), '!klcd!ma:ri')
end

os.exit(lu.LuaUnit.run())
