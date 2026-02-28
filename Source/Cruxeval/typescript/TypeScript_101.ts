function f(array: any[], i_num: number, elem: any): any[] {
    array.splice(i_num, 0, elem);
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-4, 1, 0], 1, 4),[-4, 4, 1, 0]);
}

test();
