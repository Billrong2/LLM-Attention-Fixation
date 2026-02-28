function f(bots){
    let clean = [];
    for (let username of bots) {
        if (username !== username.toUpperCase()) {
            clean.push(username.slice(0, 2) + username.slice(-3));
        }
    }
    return clean.length;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["yR?TAJhIW?n", "o11BgEFDfoe", "KnHdn2vdEd", "wvwruuqfhXbGis"]),4);
}

test();
