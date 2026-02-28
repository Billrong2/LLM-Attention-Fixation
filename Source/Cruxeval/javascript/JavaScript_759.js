function f(text, sub){
    let index = [];
    let starting = 0;
    while (starting !== -1) {
        starting = text.indexOf(sub, starting);
        if (starting !== -1) {
            index.push(starting);
            starting += sub.length;
        }
    }
    return index;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("egmdartoa", "good"),[]);
}

test();
