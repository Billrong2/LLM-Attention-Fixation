local function f(array, arr)
    local result = {}
    for i, s in pairs(arr) do
        local index = table.find(array, s)
        local split_arr = {}
        for token in string.gmatch(s, "[^"..arr[index].."]+") do
            table.insert(split_arr, token)
        end
        for _, l in pairs(split_arr) do
            if l ~= '' then
                table.insert(result, l)
            end
        end
    end
    return result
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, {}), {})
end

os.exit(lu.LuaUnit.run())
