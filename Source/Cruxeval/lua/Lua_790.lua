local function f(d)
    local r = {}
    r['c'] = {}
    r['d'] = {}

    -- Copy the dictionary
    for k, v in pairs(d) do
        r['c'][k] = v
        r['d'][k] = v
    end

    -- Check equality
    local is_equal = true
    for k, v in pairs(r['c']) do
        if r['d'][k] ~= v then
            is_equal = false
            break
        end
    end

    return {r['c'] == r['d'], is_equal}
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['i'] = '1', ['love'] = 'parakeets'}), {false, true})
end

os.exit(lu.LuaUnit.run())
