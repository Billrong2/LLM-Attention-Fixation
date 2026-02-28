local function f(text, pref)
    if type(pref) == "table" then
        local results = {}
        for i, x in ipairs(pref) do
            table.insert(results, text:sub(1, #x) == x)
        end
        return table.concat(results, ", ")
    else
        return text:sub(1, #pref) == pref
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Hello World', 'W'), false)
end

os.exit(lu.LuaUnit.run())
