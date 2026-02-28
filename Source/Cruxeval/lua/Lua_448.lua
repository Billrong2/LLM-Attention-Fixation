local function f(text, suffix)
    if suffix == '' then
        suffix = nil
    end
    return string.sub(text, -string.len(suffix)) == suffix
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('uMeGndkGh', 'kG'), false)
end

os.exit(lu.LuaUnit.run())
