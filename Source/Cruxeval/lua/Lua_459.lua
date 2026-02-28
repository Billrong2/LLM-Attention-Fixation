function f(arr, d)
    for i = 2, #arr, 2 do
        d[arr[i]] = arr[i-1]
    end

    return d
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'b', 'vzjmc', 'f', 'ae', '0'}, {}), {['vzjmc'] = 'b', ['ae'] = 'f'})
end

os.exit(lu.LuaUnit.run())
