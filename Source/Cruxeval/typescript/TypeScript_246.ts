function f(haystack: string, needle: string): number {
    for (let i = haystack.indexOf(needle); i >= 0; i--) {
        if (haystack.slice(i) === needle) {
            return i;
        }
    }
    return -1;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("345gerghjehg", "345"),-1);
}

test();
