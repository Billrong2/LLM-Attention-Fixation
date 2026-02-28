local function f(code)
    local lines = {}
    for line in string.gmatch(code, "[^%]]+") do
        table.insert(lines, line)
    end

    local result = {}
    local level = 0
    for _, line in ipairs(lines) do
        table.insert(result, string.sub(line, 1, 1) .. ' ' .. string.rep('  ', level) .. string.sub(line, 2))
        level = level + string.len(string.gsub(line, "{", "")) - string.len(string.gsub(line, "}", ""))
    end

    return table.concat(result, '\n')
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('if (x) {y = 1;} else {z = 1;}'), 'i f (x) {y = 1;} else {z = 1;}')
end

os.exit(lu.LuaUnit.run())
