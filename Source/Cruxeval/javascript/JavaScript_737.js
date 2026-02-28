function f(nums){
    let counts = 0;
    nums.forEach(i => {
        if (!isNaN(i)) {
            if (counts === 0) {
                counts += 1;
            }
        }
    });
    return counts;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 6, 2, -1, -2]),1);
}

test();
