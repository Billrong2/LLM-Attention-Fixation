local function f(array)
    while contains(array, -1) do
        table.remove(array, #array-2)
    end
    while contains(array, 0) do
        table.remove(array, #array)
    end
    while contains(array, 1) do
        table.remove(array, 1)
    end
    return array
end

function contains(table, element)
   for _, value in ipairs(table) do
      if value == element then
         return true
      end
   end
   return false
end

lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({0, 2}), {})
end

os.exit(lu.LuaUnit.run())
