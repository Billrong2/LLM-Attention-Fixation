function f(array: any[], index: number): any {
    if (index < 0) {
        index = array.length + index;
    }
    return array[index];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1], 0),1);
}

test();
