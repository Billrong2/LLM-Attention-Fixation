local function swap_case(s)
    local res = ''
    for i = 1, #s do
        local c = s:sub(i,i)
        if c:lower() == c then
            res = res..c:upper()
        else
            res = res..c:lower()
        end
    end
    return res
end

local function f(text)
    local index = 1
    while index < string.len(text) do
        if string.sub(text, index, index) ~= string.sub(text, index + 1, index + 1) then
            index = index + 1
        else
            local text1 = string.sub(text, 1, index)
            local text2 = swap_case(string.sub(text, index + 1))
            return text1 .. text2
        end
    end
    return swap_case(text)
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('USaR'), 'usAr')
end

os.exit(lu.LuaUnit.run())
