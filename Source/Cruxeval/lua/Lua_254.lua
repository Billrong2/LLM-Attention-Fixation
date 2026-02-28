local function f(text, repl)
    local trans = {}
    for i = 1, #text do
        trans[text:sub(i, i):lower()] = repl:sub(i, i):lower()
    end
    local result = ""
    for i = 1, #text do
        local char = text:sub(i, i):lower()
        if trans[char] then
            result = result .. trans[char]
        else
            result = result .. char
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('upper case', 'lower case'), 'lwwer case')
end

os.exit(lu.LuaUnit.run())
