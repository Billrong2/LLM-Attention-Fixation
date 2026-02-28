function f(lst: number[]): number[] {
    const result: number[] = [];
    let i: number = lst.length - 1;
    for (let _ of lst) {
        if (i % 2 === 0) {
            result.push(-lst[i]);
        } else {
            result.push(lst[i]);
        }
        i--;
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 7, -1, -3]),[-3, 1, 7, -1]);
}

test();
