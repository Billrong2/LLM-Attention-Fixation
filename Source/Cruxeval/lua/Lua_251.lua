local function f(messages)
    local phone_code = {'+', '3', '5', '3'}
    local result = {}
    for _, message in ipairs(messages) do
        for _, c in ipairs(phone_code) do
            table.insert(message, c)
        end
        table.insert(result, table.concat(message, ';'))
    end
    return table.concat(result, '. ')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({{'Marie', 'Nelson', 'Oscar'}}), 'Marie;Nelson;Oscar;+;3;5;3')
end

os.exit(lu.LuaUnit.run())
