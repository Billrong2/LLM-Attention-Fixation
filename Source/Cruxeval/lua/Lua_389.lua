local function f(total, arg)
    if type(arg) == "table" then
        for _, e in ipairs(arg) do
            for _, char in ipairs(e) do
                table.insert(total, char)
            end
        end
    else
        for i = 1, #arg do
            table.insert(total, arg:sub(i,i))
        end
    end
    return total
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'1', '2', '3'}, 'nammo'), {'1', '2', '3', 'n', 'a', 'm', 'm', 'o'})
end

os.exit(lu.LuaUnit.run())
