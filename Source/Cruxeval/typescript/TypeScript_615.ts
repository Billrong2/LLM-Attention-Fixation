function f(in_list: number[], num: number): number {
    in_list.push(num);
    return in_list.indexOf(Math.max(...in_list.slice(0, in_list.length - 1)));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-1, 12, -6, -2], -1),1);
}

test();
