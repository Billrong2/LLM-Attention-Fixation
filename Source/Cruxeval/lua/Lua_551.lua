local function f(data)
    local members = {}
    for item, values in pairs(data) do
        for _, member in ipairs(values) do
            local is_exist = false
            for _, value in ipairs(members) do
                if value == member then
                    is_exist = true
                    break
                end
            end
            if not is_exist then
                table.insert(members, member)
            end
        end
    end
    table.sort(members)
    return members
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['inf'] = {'a', 'b'}, ['a'] = {'inf', 'c'}, ['d'] = {'inf'}}), {'a', 'b', 'c', 'inf'})
end

os.exit(lu.LuaUnit.run())
