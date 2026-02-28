local function f(text)
    local s = string.match(text, "(.-)o(.*)")
    if not s then return "-" .. text end

    local div = s:gsub("^$", "-")
    local div2 = string.gsub(s, "^$", "-")

    return div .. text .. div2
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('kkxkxxfck'), '-kkxkxxfck')
end

os.exit(lu.LuaUnit.run())
