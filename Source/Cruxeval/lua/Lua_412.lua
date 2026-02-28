local function f(start, end_val, interval)
    local steps = {}
    for i = start, end_val, interval do
        table.insert(steps, i)
    end
    if table.concat(steps):find("1") then
        steps[#steps] = end_val + 1
    end
    return #steps
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(3, 10, 1), 8)
end

os.exit(lu.LuaUnit.run())
