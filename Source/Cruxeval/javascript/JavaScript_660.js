function f(num){
    let initial = [1];
    let total = initial;
    for (let i = 0; i < num; i++) {
        total = [1];
        for (let j = 0; j < total.length - 1; j++) {
            total.push(initial[j] + initial[j + 1]);
        }
        initial.push(total[total.length - 1]);
    }
    return initial.reduce((acc, curr) => acc + curr, 0);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(3),4);
}

test();
