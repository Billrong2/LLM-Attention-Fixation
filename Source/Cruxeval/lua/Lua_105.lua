local function f(text)
    if string.lower(text) == string.upper(string.sub(text, 1, 1)) .. string.sub(text, 2) then
        return string.lower(text)
    else
        return string.gsub(text, "(%a)([%w_']*)", function(first, rest)
            return first:upper() .. rest:lower()
        end)
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('PermissioN is GRANTed'), 'Permission Is Granted')
end

os.exit(lu.LuaUnit.run())
