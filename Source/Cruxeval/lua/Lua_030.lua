local function f(array)
    local result = {}
    for i, elem in ipairs(array) do
        if string.match(elem, "[%z\1-\127\194-\244][\128-\191]*") or type(elem) == "number" and not string.match(tostring(math.abs(elem)), "[%z\1-\127\194-\244][\128-\191]*") then
            table.insert(result, elem)
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'a', 'b', 'c'}), {'a', 'b', 'c'})
end

os.exit(lu.LuaUnit.run())
