local function f(replace, text, hide)
    while string.find(text, hide, 1, true) do
        replace = replace .. 'ax'
        text = string.gsub(text, hide, replace, 1)
    end
    return text
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('###', 'ph>t#A#BiEcDefW#ON#iiNCU', '.'), 'ph>t#A#BiEcDefW#ON#iiNCU')
end

os.exit(lu.LuaUnit.run())
