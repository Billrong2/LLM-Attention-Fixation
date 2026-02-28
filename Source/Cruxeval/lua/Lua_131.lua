local function f(text)
    local a = string.len(text)
    local count = 0
    while text ~= "" do
        if string.sub(text, 1, 1) == 'a' then
            local space_index = string.find(text, " ")
            if space_index then
                count = count + space_index - 1
            else
                count = count - 1
            end
        else
            local newline_index = string.find(text, "\n")
            if newline_index then
                count = count + newline_index - 1
            else
                count = count - 1
            end
        end
        local next_newline_index = string.find(text, "\n", 2)
        if next_newline_index then
            text = string.sub(text, next_newline_index + 1, next_newline_index + a)
        else
            text = ""
        end
    end
    return count
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('a\nkgf\nasd\n'), 1)
end

os.exit(lu.LuaUnit.run())
