function f(lst: number[], mode: number): number[] {
    const result: number[] = [...lst];
    if (mode) {
        result.reverse();
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3, 4], 1),[4, 3, 2, 1]);
}

test();
