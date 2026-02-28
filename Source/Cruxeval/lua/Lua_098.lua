local function f(s)
    local count = 0
    for word in s:gmatch("%S+") do
        if word:gsub("^%u%l*$", "") == "" then
            count = count + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('SOME OF THIS Is uknowN!'), 1)
end

os.exit(lu.LuaUnit.run())
