local function f(names)
    local count = #names
    local numberOfNames = 0
    for i = 1, count do
        if names[i]:match("^%a+$") then
            numberOfNames = numberOfNames + 1
        end
    end
    return numberOfNames
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'sharron', 'Savannah', 'Mike Cherokee'}), 2)
end

os.exit(lu.LuaUnit.run())
