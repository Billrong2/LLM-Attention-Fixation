local function f(text, s, e)
    local sublist = string.sub(text, s+1, e)
    if sublist == '' then
        return -1
    end
    local minChar = string.byte(sublist)
    for i = 1, #sublist do
        minChar = math.min(minChar, string.byte(sublist:sub(i, i)))
    end
    return string.find(sublist, string.char(minChar), 1, true) - 1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('happy', 0, 3), 1)
end

os.exit(lu.LuaUnit.run())
