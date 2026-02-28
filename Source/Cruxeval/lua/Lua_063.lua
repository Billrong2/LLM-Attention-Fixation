local function f(text, prefix)
    while text:sub(1, #prefix) == prefix do
        text = text:sub(#prefix + 1) or text
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('ndbtdabdahesyehu', 'n'), 'dbtdabdahesyehu')
end

os.exit(lu.LuaUnit.run())
