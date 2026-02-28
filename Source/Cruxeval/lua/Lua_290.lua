local function f(text, prefix)
    if text:sub(1, #prefix) == prefix then
        return text:sub(#prefix + 1)
    end
    if string.find(text, prefix) then
        return string.gsub(text, prefix, ''):gsub("^%s*(.-)%s*$", "%1")
    end
    return text:upper()
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('abixaaaily', 'al'), 'ABIXAAAILY')
end

os.exit(lu.LuaUnit.run())
