local function f(text, char)
    local count = 0
    for i = 1, string.len(text) do
        if string.sub(text, i, i) == char then
            count = count + 1
        end
    end
    if count > 0 then
        local chars = {}
        for i = 1, string.len(text) do
            table.insert(chars, string.sub(text, i, i))
        end
        local index = -1
        for i = 1, #chars do
            if chars[i] == char then
                index = i
                break
            end
        end
        local subchars = {}
        for i = index+1, index+count do
            table.insert(subchars, chars[i])
        end
        for i = 1, #subchars do
            chars[i] = subchars[i]
        end
        return table.concat(chars)
    else
        return text
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('tezmgvn 651h', '6'), '5ezmgvn 651h')
end

os.exit(lu.LuaUnit.run())
