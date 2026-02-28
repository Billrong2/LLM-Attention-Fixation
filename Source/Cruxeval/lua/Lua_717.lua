local function f(text)
    local k, l = 1, string.len(text)
    while not text:sub(l, l):match("%a") do
        l = l - 1
    end
    while not text:sub(k, k):match("%a") do
        k = k + 1
    end
    if k ~= 1 or l ~= string.len(text) then
        return string.sub(text, k, l)
    else
        return text:sub(1, 1)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('timetable, 2mil'), 't')
end

os.exit(lu.LuaUnit.run())
