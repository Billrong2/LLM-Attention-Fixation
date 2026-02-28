local function f(x)
    if #x == 0 then
        return -1
    else
        local cache = {}
        for i = 1, #x do
            local item = x[i]
            if cache[item] then
                cache[item] = cache[item] + 1
            else
                cache[item] = 1
            end
        end
        local maxVal = -1
        for k, v in pairs(cache) do
            if v > maxVal then
                maxVal = v
            end
        end
        return maxVal
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({1, 0, 2, 2, 0, 0, 0, 1}), 4)
end

os.exit(lu.LuaUnit.run())
