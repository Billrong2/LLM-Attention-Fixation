local function f(chemicals, num)
    local fish = {}
    for i = 2, #chemicals do
        table.insert(fish, chemicals[i])
    end
    local reversedChemicals = {}
    for i = #chemicals, 1, -1 do
        table.insert(reversedChemicals, chemicals[i])
    end
    
    for i = 1, num do
        table.insert(fish, table.remove(reversedChemicals, 2))
    end
    
    local finalChemicals = {}
    for i = #reversedChemicals, 1, -1 do
        table.insert(finalChemicals, reversedChemicals[i])
    end
    
    return finalChemicals
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'lsi', 's', 't', 't', 'd'}, 0), {'lsi', 's', 't', 't', 'd'})
end

os.exit(lu.LuaUnit.run())
