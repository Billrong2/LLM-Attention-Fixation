function f(plot, delin)
    for i = 1, #plot do
        if plot[i] == delin then
            local first = {}
            for j = 1, i - 1 do
                table.insert(first, plot[j])
            end

            local second = {}
            for j = i + 1, #plot do
                table.insert(second, plot[j])
            end

            local result = {}
            for _, v in ipairs(first) do table.insert(result, v) end
            for _, v in ipairs(second) do table.insert(result, v) end

            return result
        end
    end
    return plot
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 2, 3, 4}, 3), {1, 2, 4})
end

os.exit(lu.LuaUnit.run())
