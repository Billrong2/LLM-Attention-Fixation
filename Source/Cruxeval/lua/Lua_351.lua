local function f(text)
    while string.find(text, 'nnet lloP') do
        text = string.gsub(text, 'nnet lloP', 'nnet loLp')
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a_A_b_B3 '), 'a_A_b_B3 ')
end

os.exit(lu.LuaUnit.run())
