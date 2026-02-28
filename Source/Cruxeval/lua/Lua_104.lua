local function f(text)
    local dic = {}
    for i = 1, #text do
        local char = text:sub(i, i)
        dic[char] = (dic[char] or 0) + 1
    end
    for key, value in pairs(dic) do
        if value > 1 then
            dic[key] = 1
        end
    end
    return dic
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a'), {['a'] = 1})
end

os.exit(lu.LuaUnit.run())
