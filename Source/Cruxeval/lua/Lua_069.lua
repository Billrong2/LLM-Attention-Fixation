local function f(student_marks, name)
    if student_marks[name] ~= nil then
        local value = student_marks[name]
        student_marks[name] = nil
        return value
    end
    return 'Name unknown'
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['882afmfp'] = 56}, '6f53p'), 'Name unknown')
end

os.exit(lu.LuaUnit.run())
