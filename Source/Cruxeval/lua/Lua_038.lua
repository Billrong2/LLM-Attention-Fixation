local function f(string)
    return string:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest:lower()
    end):gsub("%s", "")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('1oE-err bzz-bmm'), '1Oe-ErrBzz-Bmm')
end

os.exit(lu.LuaUnit.run())
