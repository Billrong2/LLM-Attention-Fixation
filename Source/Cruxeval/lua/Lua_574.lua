local function f(simpons)
    while #simpons > 0 do
        local pop = table.remove(simpons)
        if pop == string.upper(pop:sub(1,1)) .. pop:sub(2) then
            return pop
        end
    end
    return pop
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'George', 'Michael', 'George', 'Costanza'}), 'Costanza')
end

os.exit(lu.LuaUnit.run())
