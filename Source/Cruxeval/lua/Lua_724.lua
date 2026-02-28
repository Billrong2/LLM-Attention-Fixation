local function f(text, func)
    local cites = {string.len(text:sub(text:find(func) + string.len(func)))}
    for char in text:gmatch(".") do
        if char == func then
            table.insert(cites, string.len(text:sub(text:find(func) + string.len(func))))
        end
    end
    return cites
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('010100', '010'), {3})
end

os.exit(lu.LuaUnit.run())
