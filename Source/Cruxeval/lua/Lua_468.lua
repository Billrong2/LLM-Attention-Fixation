function f(a, b, n)
    local result = b
    local m = b
    for i = 1, n do
        if m ~= '' then
            local pos = string.find(a, m, 1, true)
            if pos ~= nil then
                a = string.sub(a, 1, pos - 1) .. string.sub(a, pos + string.len(m))
                m = ''
                result = b
            end
        end
    end
    local parts = {}
    for part in string.gmatch(a, "[^" .. b .. "]+") do
        table.insert(parts, part)
    end
    return table.concat(parts, b)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('unrndqafi', 'c', 2), 'unrndqafi')
end

os.exit(lu.LuaUnit.run())
