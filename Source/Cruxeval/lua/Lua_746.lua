local function f(dct)
    local values = {}
    for k, v in pairs(dct) do
        table.insert(values, v)
    end

    local result = {}
    for _, value in ipairs(values) do
        local item = string.match(value, "(.-)%.") .. "@pinc.uk"
        result[value] = item
    end

    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())
