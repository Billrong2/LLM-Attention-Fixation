local function f(text)
    local nums = {}
    for i=1, #text do
        if tonumber(text:sub(i, i)) then
            table.insert(nums, text:sub(i, i))
        end
    end
    assert(#nums > 0, "No numeric characters found")
    return table.concat(nums)
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('-123   \t+314'), '123314')
end

os.exit(lu.LuaUnit.run())
