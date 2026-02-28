local function f(text)
    local arr = {}
    for word in text:gmatch("%S+") do
        if word:sub(-3) == "day" then
            word = word:sub(1, -4) .. "y"
        else
            word = word .. "day"
        end
        table.insert(arr, word)
    end
    return table.concat(arr, " ")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('nwv mef ofme bdryl'), 'nwvday mefday ofmeday bdrylday')
end

os.exit(lu.LuaUnit.run())
