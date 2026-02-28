function f(numbers: number[]): number[] {
    const new_numbers: number[] = [];
    for (let i = 0; i < numbers.length; i++) {
        new_numbers.push(numbers[numbers.length - 1 - i]);
    }
    return new_numbers;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([11, 3]),[3, 11]);
}

test();
