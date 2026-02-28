local function f(text, rules)
    for i, rule in ipairs(rules) do
        if rule == '@' then
            text = string.reverse(text)
        elseif rule == '~' then
            text = string.upper(text)
        elseif text ~= '' and string.sub(text, -1) == rule then
            text = string.sub(text, 1, -2)
        end
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('hi~!', {'~', '`', '!', '&'}), 'HI~')
end

os.exit(lu.LuaUnit.run())
