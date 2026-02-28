local function f(ip, n)
    local i = 0
    local out = ''
    for c in string.gmatch(ip, ".") do
        if i == n then
            out = out .. '\n'
            i = 0
        end
        i = i + 1
        out = out .. c
    end
    return out
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dskjs hjcdjnxhjicnn', 4), 'dskj\ns hj\ncdjn\nxhji\ncnn')
end

os.exit(lu.LuaUnit.run())
