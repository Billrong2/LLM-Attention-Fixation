function f(numbers: number[], index: number): number[] {
    for (let n of numbers.slice(index)) {
        numbers.splice(index, 0, n);
        index++;
    }
    return numbers.slice(0, index);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-2, 4, -4], 0),[-2, 4, -4]);
}

test();
