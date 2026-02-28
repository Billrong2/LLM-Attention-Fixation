local function f(items, target)
    local split_items = {}
    for i in string.gmatch(items, "%S+") do
        table.insert(split_items, i)
    end
    for index, value in ipairs(split_items) do
        if string.find(target, value) then
            return index
        end
        if string.sub(value, -1) == '.' or string.sub(value, 1, 1) == '.' then
            return 'error'
        end
    end
    return '.'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('qy. dg. rnvprt rse.. irtwv tx..', 'wtwdoacb'), 'error')
end

os.exit(lu.LuaUnit.run())
