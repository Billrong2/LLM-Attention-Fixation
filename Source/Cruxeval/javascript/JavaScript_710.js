function f(playlist, liker_name, song_index){
    playlist[liker_name] = playlist[liker_name] || [];
    playlist[liker_name].push(song_index);
    return playlist;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"aki": ["1", "5"]}, "aki", "2"),{"aki": ["1", "5", "2"]});
}

test();
