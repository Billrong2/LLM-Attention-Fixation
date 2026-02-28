local function f(key, value)
    local dict_ = {}
    dict_[key] = value
    for k, v in pairs(dict_) do
        return {k, v}
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('read', 'Is'), {'read', 'Is'})
end

os.exit(lu.LuaUnit.run())
