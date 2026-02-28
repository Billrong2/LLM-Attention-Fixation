local function f(years)
    local a10 = 0
    local a90 = 0
    for i = 1, #years do
        if years[i] <= 1900 then
            a10 = a10 + 1
        elseif years[i] > 1910 then
            a90 = a90 + 1
        end
    end

    if a10 > 3 then
        return 3
    elseif a90 > 3 then
        return 1
    else
        return 2
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1872, 1995, 1945}), 2)
end

os.exit(lu.LuaUnit.run())
