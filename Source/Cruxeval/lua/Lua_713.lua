local function f(text, char)
    if string.find(text, char) then
        local text_table = {}
        for t in string.gmatch(text, "[^" .. char .. "]+") do
            if string.match(t, "%S") then
                table.insert(text_table, t)
            end
        end
        if #text_table > 1 then
            return true
        end
    end
    return false
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('only one line', ' '), true)
end

os.exit(lu.LuaUnit.run())
