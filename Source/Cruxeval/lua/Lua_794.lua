local function f(line)
    local a = {}
    for i = 1, string.len(line) do
        local c = string.sub(line, i, i)
        if string.match(c, "%w") then
            table.insert(a, c)
        end
    end
    return table.concat(a)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('"\\%$ normal chars $%~ qwet42\''), 'normalcharsqwet42')
end

os.exit(lu.LuaUnit.run())
