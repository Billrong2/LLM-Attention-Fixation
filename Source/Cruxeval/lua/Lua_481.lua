local function f(values, item1, item2)
    if values[#values] == item2 then
        local exists = false
        for i=2, #values do
            if values[1] == values[i] then
                exists = true
                break
            end
        end
        if not exists then
            table.insert(values, values[1])
        end
    elseif values[#values] == item1 then
        if values[1] == item2 then
            table.insert(values, values[1])
        end
    end
    return values
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 1}, 2, 3), {1, 1})
end

os.exit(lu.LuaUnit.run())
