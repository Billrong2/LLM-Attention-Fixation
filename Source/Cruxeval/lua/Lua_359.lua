local function f(lines)
    local maxLen = #lines[#lines]
    for i = 1, #lines do
        lines[i] = string.rep(" ", math.floor((maxLen - #lines[i]) / 2)) .. lines[i]
    end
    return lines
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'dZwbSR', 'wijHeq', 'qluVok', 'dxjxbF'}), {'dZwbSR', 'wijHeq', 'qluVok', 'dxjxbF'})
end

os.exit(lu.LuaUnit.run())
