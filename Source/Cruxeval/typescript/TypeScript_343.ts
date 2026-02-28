function f(array: any[], elem: any[]): any[] {
    array.push(...elem);
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[1, 2, 3], [1, 2], 1], [[1, 2, 3], 3, [2, 1]]),[[1, 2, 3], [1, 2], 1, [1, 2, 3], 3, [2, 1]]);
}

test();
