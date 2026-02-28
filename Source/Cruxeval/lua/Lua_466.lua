local function f(text)
    local length = string.len(text)
    local index = 1
    while index <= length and string.sub(text, index, index):find("%s") do
        index = index + 1
    end
    return string.sub(text, index, index + 4)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('-----\t\n\tth\n-----'), '-----')
end

os.exit(lu.LuaUnit.run())
