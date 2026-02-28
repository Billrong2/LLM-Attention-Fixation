function f(array)
    local c = array
    local array_copy = array

    while true do
        table.insert(c, '_')
        if table.concat(c) == table.concat(array_copy) then
            array_copy[table.concat(c):find('_')] = ''
            break
        end
    end

    return array_copy
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {''})
end

os.exit(lu.LuaUnit.run())
