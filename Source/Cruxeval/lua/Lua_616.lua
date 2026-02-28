local function f(body)
    local ls = {}
    for i = 1, #body do
        table.insert(ls, body:sub(i, i))
    end
    local dist = 0
    for i = 1, #ls - 1 do
        local prev_tab_idx = i - 2
        if prev_tab_idx >= 1 and ls[prev_tab_idx] == '\t' then
            dist = dist + (1 + (ls[i - 1]:gsub('[^\t]', ''):len())) * 3
        end
        ls[i] = '[' .. ls[i] .. ']'
    end
    return table.concat(ls):gsub('\t', (' '):rep(4 + dist))
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate('\n\ny\n'), '[\n][\n][y]\n')
end

os.exit(lu.LuaUnit.run())
