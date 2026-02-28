local function f(values, text, markers)
    return text:match("^["..values..markers.."]*(.-)["..values..markers.."]*$")
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('2Pn', 'yCxpg2C2Pny2', ''), 'yCxpg2C2Pny')
end

os.exit(lu.LuaUnit.run())
