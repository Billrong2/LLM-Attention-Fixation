local function f(stg, tabs)
    for i, tab in ipairs(tabs) do
        stg = string.match(stg, tab .. "$") and string.gsub(stg, tab .. "$", "") or stg
    end
    return stg
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('31849 let it!31849 pass!', {'3', '1', '8', ' ', '1', '9', '2', 'd'}), '31849 let it!31849 pass!')
end

os.exit(lu.LuaUnit.run())
