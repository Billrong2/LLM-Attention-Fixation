local function f(text)
    local a = {}
    for line in text:gmatch("[^\n]+") do
        local c = line:gsub("\t", "    ")
        table.insert(a, c)
    end
    return table.concat(a, "\n")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('\t\t\ttab tab tabulates'), '            tab tab tabulates')
end

os.exit(lu.LuaUnit.run())
