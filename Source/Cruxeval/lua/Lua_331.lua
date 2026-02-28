local function f(strand, zmnc)
    local poz = string.find(strand, zmnc)
    while poz ~= nil do
        strand = string.sub(strand, poz + 1)
        poz = string.find(strand, zmnc)
    end
    return string.find(strand, zmnc, -#zmnc, true) or -1
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('', 'abc'), -1)
end

os.exit(lu.LuaUnit.run())
