local function f(text, value)
    local function count(s)
        local count = 0
        for i = 1, #text - #value + 1 do
            if text:sub(i, i+#value-1) == s then
                count = count + 1
            end
        end
        return count
    end

    if type(value) == 'string' then
        return count(value) + count(value:lower())
    else
        return count(value)
    end
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('eftw{ьТсk_1', '\\'), 0)
end

os.exit(lu.LuaUnit.run())
