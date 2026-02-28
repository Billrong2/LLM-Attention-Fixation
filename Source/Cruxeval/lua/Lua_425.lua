local function f(a)
    a = string.gsub(a, '/', ':')
    local _, sep, rest = string.match(a, "(.-)(:)(.*)")
    return {_, sep, rest}
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('/CL44     '), {'', ':', 'CL44     '})
end

os.exit(lu.LuaUnit.run())
