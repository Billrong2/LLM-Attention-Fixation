local function f(sentence)
    if sentence == '' then
        return ''
    end
    sentence = string.gsub(sentence, '%(', '')
    sentence = string.gsub(sentence, '%)', '')
    return string.gsub(string.gsub(string.lower(sentence), '^%l', string.upper), ' ', '')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('(A (b B))'), 'Abb')
end

os.exit(lu.LuaUnit.run())
