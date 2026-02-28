function f(array: number[], elem: number): number {
    return array.filter(x => x === elem).length + elem;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1, 1], -2),-2);
}

test();
