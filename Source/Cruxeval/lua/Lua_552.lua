function f(d)
    local result = {}
    for k, v in pairs(d) do
        if type(k) == "number" and math.floor(k) ~= k then
            for i = 1, #v do
                result[v[i]] = k
            end
        else
            result[k] = v
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[2] = 0.76, [5] = {3, 6, 9, 12}}), {[2] = 0.76, [5] = {3, 6, 9, 12}})
end

os.exit(lu.LuaUnit.run())
