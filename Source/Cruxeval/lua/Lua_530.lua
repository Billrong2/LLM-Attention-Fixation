local function f(s, ch)
    local sl = s
    if string.find(s, ch, 1, true) then
        sl = string.gsub(s, "^" .. ch .. "+", "")
        if #sl == 0 then
            sl = sl .. '!?'
        end
    else
        return 'no'
    end
    return sl
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('@@@ff', '@'), 'ff')
end

os.exit(lu.LuaUnit.run())
