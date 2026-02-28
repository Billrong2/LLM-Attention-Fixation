local function f(multi_string)
    local cond_string = {}
    for word in multi_string:gmatch("%S+") do
        table.insert(cond_string, word:match("%a+"))
    end
    for _, v in ipairs(cond_string) do
        if v then
            local result = {}
            for word in multi_string:gmatch("%S+") do
                if word:match("%a+") then
                    table.insert(result, word)
                end
            end
            return table.concat(result, ", ")
        end
    end
    return ''
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('I am hungry! eat food.'), 'I, am, hungry!, eat, food.')
end

os.exit(lu.LuaUnit.run())
