local function f(text, chunks)
    local result = {}
    for line in text:gmatch("[^\r\n]+") do
        table.insert(result, line)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('/alcm@ an)t//eprw)/e!/d\nujv', 0), {'/alcm@ an)t//eprw)/e!/d', 'ujv'})
end

os.exit(lu.LuaUnit.run())
