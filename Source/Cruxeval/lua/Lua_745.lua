local function f(address)
    local suffix_start = string.find(address, '@') + 1
    if select(2, string.gsub(string.sub(address, suffix_start), '%.', '')) > 1 then
        local parts = {}
        for part in string.gmatch(address, '([^@]+)') do
            parts[#parts + 1] = part
        end
        local to_remove = table.concat(parts, '.', 2, 3)
        address = string.gsub(address, to_remove, '')
    end
    return address
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('minimc@minimc.io'), 'minimc@minimc.io')
end

os.exit(lu.LuaUnit.run())
