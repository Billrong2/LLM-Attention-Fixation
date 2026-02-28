local function f(countries)
    local language_country = {}
    for country, language in pairs(countries) do
        if not language_country[language] then
            language_country[language] = {}
        end
        table.insert(language_country[language], country)
    end
    return language_country
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({}), {})
end

os.exit(lu.LuaUnit.run())
