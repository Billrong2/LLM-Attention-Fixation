local function f(text)
    local ls = {}
    for word in string.gmatch(text, "%w+") do
        table.insert(ls, word)
    end

    local lines = {}
    for i = 1, #ls, 3 do
        table.insert(lines, ls[i])
    end

    local res = {}
    for i = 0, 1 do
        local start_index = 3 * i + 1
        local end_index = start_index + 2
        if end_index <= #ls then
            local ln = {}
            for j = start_index, end_index do
                table.insert(ln, ls[j])
            end
            table.insert(res, table.concat(ln, " "))
        end
    end

    return lines, res
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('echo hello!!! nice!'), {'echo'})
end

os.exit(lu.LuaUnit.run())
