local function f(text)
    return string.gsub(text:gsub("(%a)([%w]*)", 
        function(first, rest)
            return first:upper()..rest:lower()
        end), "Io", "io")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('Fu,ux zfujijabji pfu.'), 'Fu,Ux Zfujijabji Pfu.')
end

os.exit(lu.LuaUnit.run())
