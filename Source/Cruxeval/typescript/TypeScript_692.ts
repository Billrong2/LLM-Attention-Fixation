function f(array: number[]): number[] {
    const a: number[] = [];
    array.reverse();
    for (let i = 0; i < array.length; i++) {
        if (array[i] !== 0) {
            a.push(array[i]);
        }
    }
    a.reverse();
    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
