function f(array: number[], lst: number[]): number[] {
    array.push(...lst);
    array.filter(e => e % 2 === 0);
    return array.filter(e => e >= 10);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([2, 15], [15, 1]),[15, 15]);
}

test();
