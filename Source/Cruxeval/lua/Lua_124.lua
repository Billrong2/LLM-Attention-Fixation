local function f(txt, sep, sep_count)
    local o = ''
    while sep_count > 0 and string.find(txt, sep) do
        local start, _ = string.find(txt, sep, -1)
        o = o .. string.sub(txt, 1, start) .. sep
        txt = string.sub(txt, start + 1)
        sep_count = sep_count - 1
    end
    return o .. txt
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('i like you', ' ', -1), 'i like you')
end

os.exit(lu.LuaUnit.run())
