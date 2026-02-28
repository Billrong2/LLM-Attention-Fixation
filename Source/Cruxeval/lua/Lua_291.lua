local function f(dictionary, arr)
    dictionary[arr[1]] = {arr[2]}
    if #dictionary[arr[1]] == arr[2] then
        dictionary[arr[1]] = arr[1]
    end
    return dictionary
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, {'a', 2}), {['a'] = {2}})
end

os.exit(lu.LuaUnit.run())
