local function f(array, ind, elem)
    local insert_pos
    if ind < 0 then
        insert_pos = math.max(1, #array + ind + 1)
    elseif ind >= #array then
        insert_pos = #array + 1
    else
        insert_pos = ind + 2
    end
    table.insert(array, insert_pos, elem)
    return array
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 5, 8, 2, 0, 3}, 2, 7), {1, 5, 8, 7, 2, 0, 3})
end

os.exit(lu.LuaUnit.run())
