local function f(text)
    local count = 0
    for i=1, #text do
        if string.find(".?!.,", text:sub(i, i), 1, true) then
            count = count + 1
        end
    end
    return count
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('bwiajegrwjd??djoda,?'), 4)
end

os.exit(lu.LuaUnit.run())
