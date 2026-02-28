function f(array: number[], elem: number): number {
    array.reverse();
    try {
        let found = array.indexOf(elem);
        return found;
    } finally {
        array.reverse();
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([5, -3, 3, 2], 2),0);
}

test();
