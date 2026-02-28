function f(mylist: number[]): boolean {
    const revl = mylist.slice().reverse();
    mylist.sort((a, b) => b - a);
    return JSON.stringify(mylist) === JSON.stringify(revl);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([5, 8]),true);
}

test();
