local function f(book)
    local a = {string.match(book, "^(.-):([^:]+)$")}
    local first_word = string.match(a[1], "%S+$")
    local last_word = string.match(a[2], "^%S+")
    
    if first_word == last_word then
        return f(string.match(a[1], "^(.-)%s.-$") .. " " .. a[2])
    end
    
    return book
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('udhv zcvi nhtnfyd :erwuyawa pun'), 'udhv zcvi nhtnfyd :erwuyawa pun')
end

os.exit(lu.LuaUnit.run())
