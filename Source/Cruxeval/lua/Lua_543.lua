local function f(item)
    local modified = string.gsub(item, '%. ', ' , ')
    modified = string.gsub(modified, '&#33; ', '! ')
    modified = string.gsub(modified, '%? ', '? ')
    modified = string.gsub(modified, '%. ', '. ')
    modified = modified:gsub("^%l", string.upper)
    return modified
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('.,,,,,. منبت'), '.,,,,, , منبت')
end

os.exit(lu.LuaUnit.run())
