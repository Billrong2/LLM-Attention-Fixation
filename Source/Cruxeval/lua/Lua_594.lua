local function f(file)
    local pos = file:find('\n')
    if pos then
        return pos - 1
    else
        return nil
    end
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('n wez szize lnson tilebi it 504n.\n'), 33)
end

os.exit(lu.LuaUnit.run())
