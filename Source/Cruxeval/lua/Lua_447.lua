local function f(text, tab_size)
    local res = ''
    text = text:gsub('\t', string.rep(' ', tab_size-1))
    for i = 1, #text do
        if text:sub(i, i) == ' ' then
            res = res .. '|'
        else
            res = res .. text:sub(i, i)
        end
    end
    return res
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('\ta', 3), '||a')
end

os.exit(lu.LuaUnit.run())
