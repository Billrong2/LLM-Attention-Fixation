function f(nums: number[]): number {
    const newNums = [...nums];
    for (let i = newNums.length - 1; i >= 0; i--) {
        if (newNums[i] % 2 !== 0) {
            newNums.splice(i, 1);
        }
    }
    
    let sum = 0;
    newNums.forEach(num => {
        sum += num;
    });
    
    return sum;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([11, 21, 0, 11]),0);
}

test();
