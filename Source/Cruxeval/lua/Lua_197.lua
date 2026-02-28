local function f(temp, timeLimit)
    local s = math.floor(timeLimit / temp)
    local e = timeLimit % temp
    if s > 1 then
        return tostring(s) .. " " .. tostring(e)
    else
        return tostring(e) .. " oC"
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(1, 1234567890), '1234567890 0')
end

os.exit(lu.LuaUnit.run())
