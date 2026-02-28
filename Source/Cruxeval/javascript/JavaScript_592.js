function f(numbers){
    let new_numbers = [];
    for (let i = 0; i < numbers.length; i++) {
        new_numbers.push(numbers[numbers.length - 1 - i]);
    }
    return new_numbers;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([11, 3]),[3, 11]);
}

test();
