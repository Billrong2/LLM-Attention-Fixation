function f(nums, target){
    if(nums.filter(num => num === 0).length > 0){
        return 0;
    } else if(nums.filter(num => num === target).length < 3){
        return 1;
    } else {
        return nums.indexOf(target);
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1, 1, 2], 3),1);
}

test();
