local function f(text)
    local i = math.floor((string.len(text) + 1) / 2)
    local result = {string.byte(text, 1, -1)}
    while i < string.len(text) do
        local t = string.lower(string.char(result[i+1]))
        if t == string.char(result[i+1]) then
            i = i + 1
        else
            result[i+1] = string.byte(t)
        end
        i = i + 2
    end
    return string.char(table.unpack(result))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('mJkLbn'), 'mJklbn')
end

os.exit(lu.LuaUnit.run())
