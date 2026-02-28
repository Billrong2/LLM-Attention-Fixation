function f(array: number[][]): number[][] {
    const return_arr: number[][] = [];
    array.forEach(a => {
        return_arr.push([...a]);
    });
    return return_arr;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[1, 2, 3], [], [1, 2, 3]]),[[1, 2, 3], [], [1, 2, 3]]);
}

test();
