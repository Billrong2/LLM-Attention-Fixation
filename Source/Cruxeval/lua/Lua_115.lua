local function f(text)
    local res = {}
    for i = 1, string.len(text) do
        local ch = string.byte(text, i)
        if ch == 61 then
            break
        elseif ch ~= 0 then
            table.insert(res, string.format("%d; ", ch))
        end
    end
    return string.format("b'%s'", table.concat(res))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('os||agx5'), "b'111; 115; 124; 124; 97; 103; 120; 53; '")
end

os.exit(lu.LuaUnit.run())
