local function f(values)
    local names = {'Pete', 'Linda', 'Angela'}
    for i = 1, #values do
        table.insert(names, values[i])
    end
    table.sort(names)
    return names
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'Dan', 'Joe', 'Dusty'}), {'Angela', 'Dan', 'Dusty', 'Joe', 'Linda', 'Pete'})
end

os.exit(lu.LuaUnit.run())
