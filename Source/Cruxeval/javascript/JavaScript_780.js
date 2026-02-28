function f(ints){
    let counts = new Array(301).fill(0);

    ints.forEach(i => {
        counts[i] += 1;
    });

    let r = [];
    for (let i = 0; i < counts.length; i++) {
        if (counts[i] >= 3) {
            r.push(String(i));
        }
    }
    counts = [];
    return r.join(' ');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2, 3, 5, 2, 4, 5, 2, 89]),"2");
}

test();
