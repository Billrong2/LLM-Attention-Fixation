function f(needle: string, haystack: string): number {
    let count: number = 0;
    while (haystack.includes(needle)) {
        haystack = haystack.replace(needle, '');
        count++;
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a", "xxxaaxaaxx"),4);
}

test();
