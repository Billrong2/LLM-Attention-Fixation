function f(num: number): number {
    let initial: number[] = [1];
    let total: number[] = initial;
    for (let i = 0; i < num; i++) {
        total = [1, ...total.map((val, index) => val + (total[index + 1] || 0))];
        initial.push(total[total.length - 1]);
    }
    return initial.reduce((acc, val) => acc + val, 0);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(3),4);
}

test();
