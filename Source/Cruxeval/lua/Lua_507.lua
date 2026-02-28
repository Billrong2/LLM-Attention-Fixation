local function f(text, search)
    local result = text:lower()
    local search_lower = search:lower()
    local start, end_pos = result:find(search_lower)
    if start then
        return start - 1
    else
        return -1
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('car hat', 'car'), 0)
end

os.exit(lu.LuaUnit.run())
