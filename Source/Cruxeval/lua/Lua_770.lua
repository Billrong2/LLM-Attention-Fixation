local function f(line, char)
    local count = select(2, string.gsub(line, char, ""))
    for i = count+1, 1, -1 do
        local new_width = string.len(line) + math.floor(i / string.len(char))
        line = string.rep(char, math.floor((new_width - string.len(line)) / 2)) .. line .. string.rep(char, math.ceil((new_width - string.len(line)) / 2))
    end
    return line
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('$78', '$'), '$$78$$')
end

os.exit(lu.LuaUnit.run())
