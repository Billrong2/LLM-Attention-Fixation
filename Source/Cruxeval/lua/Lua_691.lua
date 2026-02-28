local function f(text, suffix)
    if suffix ~= '' and string.sub(suffix, -1) ~= '' then
        local last_char = string.sub(suffix, -1)
        text = string.gsub(text, last_char .. "*$", "")
        suffix = string.sub(suffix, 1, -2)
        return f(text, suffix)
    else
        return text
    end
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('rpyttc', 'cyt'), 'rpytt')
end

os.exit(lu.LuaUnit.run())
