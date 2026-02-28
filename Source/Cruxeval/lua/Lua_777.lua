local function f(names, excluded)
    for i=1, #names do
        if string.find(names[i], excluded) then
            names[i] = string.gsub(names[i], excluded, "")
        end
    end
    return names
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'avc  a .d e'}, ''), {'avc  a .d e'})
end

os.exit(lu.LuaUnit.run())
