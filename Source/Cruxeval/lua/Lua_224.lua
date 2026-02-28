local function f(array, value)
    table.sort(array, function(a, b) return a > b end)
    table.remove(array)
    local odd = {}
    while #array > 0 do
        local tmp = {}
        tmp[array[#array]] = value
        table.remove(array)
        table.insert(odd, tmp)
    end
    local result = {}
    while #odd > 0 do
        local tmp = odd[#odd]
        for k, v in pairs(tmp) do
            result[k] = v
        end
        table.remove(odd)
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'23'}, 123), {})
end

os.exit(lu.LuaUnit.run())
