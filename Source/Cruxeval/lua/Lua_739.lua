local function f(st, pattern)
    for i, p in ipairs(pattern) do
        if string.sub(st, 1, string.len(p)) ~= p then
            return false
        end
        st = string.sub(st, string.len(p) + 1)
    end
    return true
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qwbnjrxs', {'jr', 'b', 'r', 'qw'}), false)
end

os.exit(lu.LuaUnit.run())
