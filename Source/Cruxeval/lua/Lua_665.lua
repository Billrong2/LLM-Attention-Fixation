local function f(chars)
    local s = ""
    for i = 1, #chars do
        local ch = string.sub(chars, i, i)
        if string.len(chars:gsub(ch, "")) % 2 == 0 then
            s = s .. string.upper(ch)
        else
            s = s .. ch
        end
    end
    return s
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('acbced'), 'aCbCed')
end

os.exit(lu.LuaUnit.run())
