local function f(bots)
    local clean = {}
    for i, username in ipairs(bots) do
        if string.lower(username) ~= username then
            table.insert(clean, string.sub(username, 1, 2) .. string.sub(username, -3))
        end
    end
    return #clean
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'yR?TAJhIW?n', 'o11BgEFDfoe', 'KnHdn2vdEd', 'wvwruuqfhXbGis'}), 4)
end

os.exit(lu.LuaUnit.run())
