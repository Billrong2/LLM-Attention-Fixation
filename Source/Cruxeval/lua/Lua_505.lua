local function f(string)
    while string:len() > 0 do
        if string:sub(-1):match("%a") then
            return string
        end
        string = string:sub(1, -2)
    end
    return string
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('--4/0-209'), '')
end

os.exit(lu.LuaUnit.run())
