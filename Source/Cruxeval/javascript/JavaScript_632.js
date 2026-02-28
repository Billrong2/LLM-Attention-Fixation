function f(lst){
    for (let i = lst.length - 1; i > 0; i--) {
        for (let j = 0; j < i; j++) {
            if (lst[j] > lst[j + 1]) {
                [lst[j], lst[j + 1]] = [lst[j + 1], lst[j]];
            }
        }
    }
    return lst;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([63, 0, 1, 5, 9, 87, 0, 7, 25, 4]),[0, 0, 1, 4, 5, 7, 9, 25, 63, 87]);
}

test();
