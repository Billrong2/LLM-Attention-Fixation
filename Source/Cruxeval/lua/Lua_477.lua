local function f(text)
    local topic, problem
    local sep_pos = text:match(".*()|")
    if sep_pos then
        topic = text:sub(1, sep_pos - 1)
        problem = text:sub(sep_pos + 1)
    else
        topic = ""
        problem = text
    end
    if problem == 'r' then
        problem = topic:gsub('u', 'p')
    end
    return {topic, problem}
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('|xduaisf'), {'', 'xduaisf'})
end

os.exit(lu.LuaUnit.run())
