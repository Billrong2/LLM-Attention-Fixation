local function f(text, tabsize)
    local lines = {}
    for line in text:gmatch("[^\r\n]+") do
        local new_line = line:gsub("\t", string.rep(" ", tabsize))
        table.insert(lines, new_line)
    end
    return table.concat(lines, "\n")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('\tf9\n\tldf9\n\tadf9!\n\tf9?', 1), ' f9\n ldf9\n adf9!\n f9?')
end

os.exit(lu.LuaUnit.run())
