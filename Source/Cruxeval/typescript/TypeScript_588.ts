function f(items: string[], target: string): number {
    if (items.includes(target)) {
        return items.indexOf(target);
    }
    return -1;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["1", "+", "-", "**", "//", "*", "+"], "**"),3);
}

test();
