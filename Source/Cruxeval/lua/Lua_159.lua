local function f(st)
    local swapped = ''
    for i = string.len(st), 1, -1 do
        local ch = string.sub(st, i, i)
        if ch:match('[a-z]') then
            swapped = swapped .. ch:upper()
        elseif ch:match('[A-Z]') then
            swapped = swapped .. ch:lower()
        else
            swapped = swapped .. ch
        end
    end
    return swapped
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('RTiGM'), 'mgItr')
end

os.exit(lu.LuaUnit.run())
