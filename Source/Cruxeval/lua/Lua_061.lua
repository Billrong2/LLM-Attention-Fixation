local function f(text)
    local texts = {}
    for word in text:gmatch("%S+") do
        table.insert(texts, word)
    end

    if #texts > 0 then
        local xtexts = {}
        for _, t in ipairs(texts) do
            if t:match("[%z\1-\127\194-\244][\128-\191]*") and t ~= "nada" and t ~= "0" then
                table.insert(xtexts, t)
            end
        end

        if #xtexts > 0 then
            local longest = xtexts[1]
            for _, v in ipairs(xtexts) do
                if #v > #longest then
                    longest = v
                end
            end
            return longest
        else
            return "nada"
        end
    else
        return "nada"
    end
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate(''), 'nada')
end

os.exit(lu.LuaUnit.run())
