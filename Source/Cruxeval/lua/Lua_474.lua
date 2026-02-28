function f(txt, marker)
    local a = {}
    local lines = {}
    for line in string.gmatch(txt, "[^\n]+") do
        table.insert(lines, line)
    end
    for _, line in ipairs(lines) do
        local length = math.max(#line, marker)
        local padding_left = math.floor((length - #line) / 2)
        local padding_right = length - #line - padding_left
        table.insert(a, string.rep(' ', padding_left) .. line .. string.rep(' ', padding_right))
    end
    return table.concat(a, '\n')
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('#[)[]>[^e>\n 8', -5), '#[)[]>[^e>\n 8')
end

os.exit(lu.LuaUnit.run())
