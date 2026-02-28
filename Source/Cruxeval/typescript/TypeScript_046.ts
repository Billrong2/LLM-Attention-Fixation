function f(l: string[], c: string): string {
    return l.join(c);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["many", "letters", "asvsz", "hello", "man"], ""),"manylettersasvszhelloman");
}

test();
