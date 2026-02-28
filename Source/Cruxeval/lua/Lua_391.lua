local function f(students)
    local seatlist = students
    table.sort(seatlist)
    local cnt = 0
    for cnt = 1, #seatlist do
        cnt = cnt + 2
        seatlist[cnt - 1] = '+'
    end
    table.insert(seatlist, '+')
    return seatlist
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({'r', '9'}), {'9', '+', '+', '+'})
end

os.exit(lu.LuaUnit.run())
