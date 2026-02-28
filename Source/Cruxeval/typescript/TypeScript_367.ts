function f(nums: number[], rmvalue: number): number[] {
    let res: number[] = [...nums];
    while (res.includes(rmvalue)) {
        const index = res.indexOf(rmvalue);
        const popped = res.splice(index, 1)[0];
        if (popped !== rmvalue) {
            res.push(popped);
        }
    }
    return res;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([6, 2, 1, 1, 4, 1], 5),[6, 2, 1, 1, 4, 1]);
}

test();
