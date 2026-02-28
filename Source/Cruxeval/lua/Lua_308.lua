local function f(strings)
    local occurances = {}
    for i, string in ipairs(strings) do
        if occurances[string] == nil then
            occurances[string] = 0
            for j, s in ipairs(strings) do
                if s == string then
                    occurances[string] = occurances[string] + 1
                end
            end
        end
    end
    return occurances
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'La', 'Q', '9', 'La', 'La'}), {['La'] = 3, ['Q'] = 1, ['9'] = 1})
end

os.exit(lu.LuaUnit.run())
