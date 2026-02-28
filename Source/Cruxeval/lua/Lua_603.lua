local function f(sentences)
    local isOscillating = true
    for sentence in string.gmatch(sentences, "[^.]+") do
        if not tonumber(sentence) then
            isOscillating = false
            break
        end
    end
    
    if isOscillating then
        return 'oscillating'
    else
        return 'not oscillating'
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('not numbers'), 'not oscillating')
end

os.exit(lu.LuaUnit.run())
