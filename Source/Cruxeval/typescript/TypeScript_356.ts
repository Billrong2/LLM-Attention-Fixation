function f(array: number[], num: number): number[] {
    let reverse = false;
    if (num < 0) {
        reverse = true;
        num *= -1;
    }
    let reversedArray = array.slice().reverse();
    let repeatedArray = reversedArray.concat(...Array(num - 1).fill(reversedArray)).flat();
    let resultArray = reverse ? repeatedArray.reverse() : repeatedArray;
    
    return resultArray;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2], 1),[2, 1]);
}

test();
