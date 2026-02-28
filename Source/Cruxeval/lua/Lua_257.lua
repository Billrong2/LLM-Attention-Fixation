local function f(text)
    local ls = {}
    for i, x in ipairs(text) do
        ls[i] = {}
        for line in x:gmatch("[^\n]+") do
            table.insert(ls[i], line)
        end
    end
    return ls
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'Hello World\n"I am String"'}), {{'Hello World', '"I am String"'}})
end

os.exit(lu.LuaUnit.run())
