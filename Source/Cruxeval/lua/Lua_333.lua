local function f(places, lazy)
    table.sort(places)
    for _, l in ipairs(lazy) do
        for i, v in ipairs(places) do
            if v == l then
                table.remove(places, i)
                break
            end
        end
    end
    if #places == 1 then
        return 1
    end
    for i, place in ipairs(places) do
        local count = 0
        for _, v in ipairs(places) do
            if v == place + 1 then
                count = count + 1
            end
        end
        if count == 0 then
            return i
        end
    end
    return #places
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({375, 564, 857, 90, 728, 92}, {728}), 1)
end

os.exit(lu.LuaUnit.run())
