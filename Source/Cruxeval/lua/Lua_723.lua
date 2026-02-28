function f(text, separator)
    local splitted = {}
    for str in text:gmatch("[^\n\r]*") do
        table.insert(splitted, str)
    end
    if separator ~= 0 then
        for i = 1, #splitted do
            local str_arr = {}
            for j = 1, #splitted[i] do
                table.insert(str_arr, string.sub(splitted[i], j, j))
            end
            splitted[i] = table.concat(str_arr, " ")
        end
    end
    return splitted
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('dga nqdk\rull qcha kl', 1), {'d g a   n q d k', 'u l l   q c h a   k l'})
end

os.exit(lu.LuaUnit.run())
