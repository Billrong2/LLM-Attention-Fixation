local function f(text, prefix)
    local idx = 1
    for i = 1, #prefix do
        if text:sub(idx, idx) ~= prefix:sub(i, i) then
            return nil
        end
        idx = idx + 1
    end
    return text:sub(idx)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('bestest', 'bestest'), '')
end

os.exit(lu.LuaUnit.run())
