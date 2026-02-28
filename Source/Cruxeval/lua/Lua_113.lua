local function f(line)
    local count = 0
    local a = {}
    for i = 1, string.len(line) do
        count = count + 1
        if count%2==0 then
            local character = string.sub(line, i, i)
            if string.lower(character) == character then
                table.insert(a, string.upper(character))
            else
                table.insert(a, string.lower(character))
            end
        else
            table.insert(a, string.sub(line, i, i))
        end
    end
    return table.concat(a)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('987yhNSHAshd 93275yrgSgbgSshfbsfB'), '987YhnShAShD 93275yRgsgBgssHfBsFB')
end

os.exit(lu.LuaUnit.run())
