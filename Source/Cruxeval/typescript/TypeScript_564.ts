function f(lists: number[][]): number[] {
    lists[1].splice(0, lists[1].length);
    lists[2] = lists[2].concat(lists[1]);
    return lists[0];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[395, 666, 7, 4], [], [4223, 111]]),[395, 666, 7, 4]);
}

test();
