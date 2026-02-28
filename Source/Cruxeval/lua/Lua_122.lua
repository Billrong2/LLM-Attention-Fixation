local function f(string)
    if string:sub(1, 4) ~= 'Nuva' then
        return 'no'
    else
        return string:gsub('%s*$', '')
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Nuva?dlfuyjys'), 'Nuva?dlfuyjys')
end

os.exit(lu.LuaUnit.run())
