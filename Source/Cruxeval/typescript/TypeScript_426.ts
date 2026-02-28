function f(numbers: any[], elem: any, idx: number): any[] {
    numbers.splice(idx, 0, elem);
    return numbers;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3], 8, 5),[1, 2, 3, 8]);
}

test();
