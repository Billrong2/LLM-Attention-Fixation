local function f(text)
    local uppercase_index = string.find(text, 'A', 1, true)
    if uppercase_index then
        return string.sub(text, 1, uppercase_index - 1) .. string.sub(text, string.find(text, 'a', 1, true) + 1)
    else
        local chars = {}
        for i = 1, string.len(text) do
            table.insert(chars, string.sub(text, i, i))
        end
        table.sort(chars)
        return table.concat(chars)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('E jIkx HtDpV G'), '   DEGHIVjkptx')
end

os.exit(lu.LuaUnit.run())
