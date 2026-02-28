local function f(container, cron)
    local index = nil
    for i, value in ipairs(container) do
        if value == cron then
            index = i
            break
        end
    end

    if index == nil then
        return container
    end

    local pref = {}
    for i = 1, index - 1 do
        table.insert(pref, container[i])
    end

    local suff = {}
    for i = index + 1, #container do
        table.insert(suff, container[i])
    end

    for i, value in ipairs(suff) do
        table.insert(pref, value)
    end

    return pref
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}, 2), {})
end

os.exit(lu.LuaUnit.run())
