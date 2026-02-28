function f(arr: number[]): string {
    let newArr: string[] = [];
    newArr.push('1');
    newArr.push('2');
    newArr.push('3');
    newArr.push('4');
    return newArr.join(',');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 1, 2, 3, 4]),"1,2,3,4");
}

test();
