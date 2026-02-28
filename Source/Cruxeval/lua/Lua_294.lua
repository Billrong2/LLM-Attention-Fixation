local function f(n, m, text)
    if text:match("^%s*$") then
        return text
    end
    local head, mid, tail = text:sub(1, 1), text:sub(2, -2), text:sub(-1)
    local joined = head:gsub(n, m) .. mid:gsub(n, m) .. tail:gsub(n, m)
    return joined
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('x', '$', '2xz&5H3*1a@#a*1hris'), '2$z&5H3*1a@#a*1hris')
end

os.exit(lu.LuaUnit.run())
