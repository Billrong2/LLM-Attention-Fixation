local function f(string)
    local tmp = string:lower()
    for i = 1, #string do
        local char = string:sub(i,i):lower()
        local pos = tmp:find(char, 1, true)
        if pos then
            tmp = tmp:sub(1, pos-1) .. tmp:sub(pos+1)
        end
    end
    return tmp
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('[ Hello ]+ Hello, World!!_ Hi'), '')
end

os.exit(lu.LuaUnit.run())
