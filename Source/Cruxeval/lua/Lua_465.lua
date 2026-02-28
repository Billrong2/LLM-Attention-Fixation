local function f(seq, value)
    local roles = {}
    for i, v in pairs(seq) do
        roles[v] = 'north'
    end
    if value then
        local split_values = {}
        for token in string.gmatch(value, "[^, ]+") do
            table.insert(split_values, token)
        end
        for i, key in pairs(split_values) do
            roles[key] = 'north'
        end
    end
    return roles
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'wise king', 'young king'}, ''), {['wise king'] = 'north', ['young king'] = 'north'})
end

os.exit(lu.LuaUnit.run())
