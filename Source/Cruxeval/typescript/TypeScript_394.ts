function f(text: string): number {
    let k = text.split('\n');
    let i = 0;
    for (let j of k) {
        if (j.length === 0) {
            return i;
        }
        i++;
    }
    return -1;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("2 m2 \n\nbike"),1);
}

test();
