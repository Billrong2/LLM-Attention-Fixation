function f(array: number[], elem: number): number {
    if (array.includes(elem)) {
        return array.indexOf(elem);
    }
    return -1;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([6, 2, 7, 1], 6),0);
}

test();
