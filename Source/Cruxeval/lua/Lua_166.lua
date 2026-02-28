function f(graph)
    local new_graph = {}
    for key, value in pairs(graph) do
        new_graph[key] = {}
        for subkey, _ in pairs(value) do
            new_graph[key][subkey] = ''
        end
    end
    return new_graph
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())
