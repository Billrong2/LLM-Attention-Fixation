local function f(instagram, imgur, wins)
    local photos = {instagram, imgur}
    if instagram == imgur then
        return wins
    end
    if wins == 1 then
        return table.remove(photos)
    else
        table.insert(photos, 1, table.remove(photos, 2))
        return table.remove(photos)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'sdfs', 'drcr', '2e'}, {'sdfs', 'dr2c', 'QWERTY'}, 0), {'sdfs', 'drcr', '2e'})
end

os.exit(lu.LuaUnit.run())
