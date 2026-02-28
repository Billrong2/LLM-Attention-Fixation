function f(array: number[], constNum: number): string[] {
    let output: string[] = ['x'];
    for(let i = 1; i <= array.length; i++) {
        if(i % 2 !== 0) {
            output.push(String(array[i - 1] * -2));
        } else {
            output.push(String(constNum));
        }
    }
    return output;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 2, 3], -1),["x", "-2", "-1", "-6"]);
}

test();
