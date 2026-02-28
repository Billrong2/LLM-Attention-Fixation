local function f(text)
    local pos = text:reverse():find('0')
    if pos == nil then
        return '-1:-1'
    else
        local l = text:len() - pos
        local m = text:sub(l + 1, l + 1)
        return tostring(l) .. ":" .. tostring(m)
    end
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qq0tt'), '2:0')
end

os.exit(lu.LuaUnit.run())
