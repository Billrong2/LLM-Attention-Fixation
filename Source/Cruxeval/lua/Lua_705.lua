local function f(cities, name)
    if name == nil or name == '' then
        return cities
    end
    if name ~= 'cities' then
        return {}
    end
    local result = {}
    for i, city in ipairs(cities) do
        table.insert(result, name .. city)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'Sydney', 'Hong Kong', 'Melbourne', 'Sao Paolo', 'Istanbul', 'Boston'}, 'Somewhere '), {})
end

os.exit(lu.LuaUnit.run())
