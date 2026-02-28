local function f(text, search_chars, replace_chars)
    local trans_table = {} 
    for i = 1, #search_chars do
        trans_table[search_chars:sub(i, i)] = replace_chars:sub(i, i)
    end
    return text:gsub(".", function(c)
        return trans_table[c] or c
    end)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('mmm34mIm', 'mm3', ',po'), 'pppo4pIp')
end

os.exit(lu.LuaUnit.run())
