local function f(text)
    local ls = {string.byte(text, 1, #text)}
    ls[1], ls[#ls] = string.upper(string.char(ls[#ls])), string.upper(string.char(ls[1]))
    return string.find(string.sub(table.concat(ls, ""), 1, 1), "%u") and string.find(string.sub(table.concat(ls, ""), 2), "%u") == nil
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Josh'), false)
end

os.exit(lu.LuaUnit.run())
