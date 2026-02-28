local function f(d)
    local result = {}
    for ki, li in pairs(d) do
        result[ki] = {}
        for kj, dj in ipairs(li) do
            result[ki][kj] = {}
            for kk, l in pairs(dj) do
                result[ki][kj][kk] = l
            end
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())
