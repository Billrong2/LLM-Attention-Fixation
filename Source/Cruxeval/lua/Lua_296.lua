local function f(url)
    return url:gsub("^http://www%.", "")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('https://www.www.ekapusta.com/image/url'), 'https://www.www.ekapusta.com/image/url')
end

os.exit(lu.LuaUnit.run())
