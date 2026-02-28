local function f(text)
    local count = select(2, string.gsub(text, text:sub(1, 1), ""))
    local ls = {}
    for i = 1, #text do
        table.insert(ls, text:sub(i, i))
    end
    for _ = 1, count do
        table.remove(ls, 1)
    end
    return table.concat(ls, "")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(';,,,?'), ',,,?')
end

os.exit(lu.LuaUnit.run())
