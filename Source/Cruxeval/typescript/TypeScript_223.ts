function f(array: number[], target: number): number {
    let count: number = 0;
    let i: number = 1;
    for (let j = 1; j < array.length; j++) {
        if (array[j] > array[j - 1] && array[j] <= target) {
            count += i;
        } else if (array[j] <= array[j - 1]) {
            i = 1;
        } else {
            i += 1;
        }
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, -1, 4], 2),1);
}

test();
