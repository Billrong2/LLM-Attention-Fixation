local function f(s, separator)
    for i=1, #s do
        if string.sub(s, i, i) == separator then
            local new_s = {}
            for j=1, #s do
                if j == i then
                    table.insert(new_s, '/')
                else
                    table.insert(new_s, string.sub(s, j, j))
                end
            end
            return table.concat(new_s, ' ')
        end
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('h grateful k', ' '), 'h / g r a t e f u l   k')
end

os.exit(lu.LuaUnit.run())
