function f(playlist, liker_name, song_index)
    playlist[liker_name] = playlist[liker_name] or {}
    table.insert(playlist[liker_name], song_index)
    return playlist
end
lu = require('luaunit')

function test_humaneval()
local candidate = f
    lu.assertEquals(candidate({['aki'] = {'1', '5'}}, 'aki', '2'), {['aki'] = {'1', '5', '2'}})
end

os.exit(lu.LuaUnit.run())
