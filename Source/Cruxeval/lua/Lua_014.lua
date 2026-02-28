local function f(s)
    local arr = {}
    s = s:gsub("^%s*(.-)%s*$", "%1")
    for i in s:gmatch(".") do
        table.insert(arr, 1, i)
    end
    return table.concat(arr)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('   OOP   '), 'POO')
end

os.exit(lu.LuaUnit.run())
