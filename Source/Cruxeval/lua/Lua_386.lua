local function f(concat, di)
    local count = 0
    for _ in pairs(di) do
        count = count + 1
    end

    local i = 0
    while i < count do
        if di[tostring(i)] and string.find(concat, di[tostring(i)]) then
            di[tostring(i)] = nil
        end
        i = i + 1
    end

    return "Done!"
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('mid', {['0'] = 'q', ['1'] = 'f', ['2'] = 'w', ['3'] = 'i'}), 'Done!')
end

os.exit(lu.LuaUnit.run())
