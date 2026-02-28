local function f(input_string)
    local table = input_string:gsub("[aioe]", {a="i", i="o", o="u", e="a"})
    while string.find(input_string, 'a') or string.find(input_string, 'A') do
        input_string = string.gsub(input_string, "[aioe]", table)
    end
    return input_string
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('biec'), 'biec')
end

os.exit(lu.LuaUnit.run())
