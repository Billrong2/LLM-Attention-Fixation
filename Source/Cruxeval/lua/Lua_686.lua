local function f(d, l)
    local new_d = {}

    for i, k in ipairs(l) do
        if d[k] ~= nil then
            new_d[k] = d[k]
        end
    end

    return new_d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['lorem ipsum'] = 12, ['dolor'] = 23}, {'lorem ipsum', 'dolor'}), {['lorem ipsum'] = 12, ['dolor'] = 23})
end

os.exit(lu.LuaUnit.run())
