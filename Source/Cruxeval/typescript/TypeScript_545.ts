function f(array: number[]): number[] {
    const result: number[] = [];
    let index: number = 0;
    while (index < array.length) {
        result.push(array.pop());
        index += 2;
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([8, 8, -4, -9, 2, 8, -1, 8]),[8, -1, 8]);
}

test();
