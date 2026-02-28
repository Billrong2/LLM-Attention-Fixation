function f(lst, start, end){
    let count = 0;
    for (let i = start; i < end; i++) {
        for (let j = i; j < end; j++) {
            if (lst[i] !== lst[j]) {
                count++;
            }
        }
    }
    return count;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 4, 3, 2, 1], 0, 3),3);
}

test();
