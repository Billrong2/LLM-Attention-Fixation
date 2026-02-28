local function f(lst)
    local i = 1
    local new_list = {}
    while i <= #lst do
        if table.concat(lst, ",", i+1):find(lst[i]) then
            table.insert(new_list, lst[i])
            if #new_list == 3 then
                return new_list
            end
        end
        i = i + 1
    end
    return new_list
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 2, 1, 2, 6, 2, 6, 3, 0}), {0, 2, 2})
end

os.exit(lu.LuaUnit.run())
