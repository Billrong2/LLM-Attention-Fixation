function f(array: number[]): string[] {
    array.reverse();
    array.length = 0;
    array.push(...Array(array.length).fill('x'));
    array.reverse();
    return array.map(String);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([3, -2, 0]),[]);
}

test();
