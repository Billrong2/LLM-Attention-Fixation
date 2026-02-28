local function f(out, mapping)
    for key, value in pairs(mapping) do
        out = string.gsub(out, "{%w+}", mapping[key][1]:reverse())
        if #string.gmatch(out, "{%w+}") == 0 then
            break
        end
    end
    return out
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('{{{{}}}}', {}), '{{{{}}}}')
end

os.exit(lu.LuaUnit.run())
