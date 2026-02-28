function f(text, width)
    local result = ""
    local lines = {}
    for line in string.gmatch(text, "([^\n]*)\n?") do
        table.insert(lines, line)
    end
    for _, l in ipairs(lines) do
        local diff = width - #l
        if diff > 0 then
            local left = diff // 2
            local right = diff - left
            result = result .. string.rep(' ', left) .. l .. string.rep(' ', right) .. '\n'
        else
            result = result .. l .. '\n'
        end
    end
    -- Remove the very last empty line
    result = result:sub(1, -2)
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('l\nl', 2), 'l \nl ')
end

os.exit(lu.LuaUnit.run())
