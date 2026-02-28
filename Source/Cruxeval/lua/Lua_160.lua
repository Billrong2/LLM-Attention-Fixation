local function f(dictionary)
    while not dictionary[1] or #dictionary == 0 do
        for k in pairs(dictionary) do
            dictionary[k] = nil
        end
        break
    end
    return dictionary
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({[1] = 47698, [1] = 32849, [1] = 38381, [3] = 83607}), {[1] = 38381, [3] = 83607})
end

os.exit(lu.LuaUnit.run())
