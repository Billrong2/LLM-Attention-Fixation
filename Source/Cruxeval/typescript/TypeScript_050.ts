function f(lst: string[]): number[] {
    lst.length = 0;
    lst.push(...Array(lst.length + 1).fill(1));
    return lst.map(Number);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["a", "c", "v"]),[1]);
}

test();
