local function f(text, char)
    local suff, pref = string.match(text, '(.*' .. char .. ')(.*)')
    if char ~= '' then
        pref = suff:sub(1, -#char-1) .. pref
        suff = suff:sub(-#char, -1) .. suff:sub(1, -#char-1)
        text = suff .. char .. pref
    end
    return text
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('uzlwaqiaj', 'u'), 'uuzlwaqiaj')
end

os.exit(lu.LuaUnit.run())
