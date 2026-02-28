local function f(a)
    for _ = 1, 10 do
        local found = false
        for j = 1, #a do
            if string.sub(a, j, j) ~= '#' then
                a = string.sub(a, j)
                found = true
                break
            end
        end
        if not found then
            a = ""
            break
        end
    end
    while string.sub(a, -1) == '#' do
        a = string.sub(a, 1, -2)
    end
    return a
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('##fiu##nk#he###wumun##'), 'fiu##nk#he###wumun')
end

os.exit(lu.LuaUnit.run())
