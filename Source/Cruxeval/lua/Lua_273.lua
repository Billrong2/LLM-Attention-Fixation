local function f(name)
    local new_name = ''
    name = string.reverse(name)
    for i = 1, string.len(name) do
        local n = string.sub(name, i, i)
        if n ~= '.' and string.len(new_name:gsub("[^.]", "")) < 2 then
            new_name = n .. new_name
        else
            break
        end
    end
    return new_name
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('.NET'), 'NET')
end

os.exit(lu.LuaUnit.run())
