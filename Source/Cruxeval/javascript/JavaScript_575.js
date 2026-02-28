function f(nums, val){
    let new_list = [];
    nums.forEach(num => {
        new_list.push(...Array(val).fill(num));
    });
    return new_list.reduce((acc, curr) => acc + curr, 0);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([10, 4], 3),42);
}

test();
