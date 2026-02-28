function f(text: string, delim: string): string {
    const [first, second] = text.split(delim);
    return second + delim + first;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("bpxa24fc5.", "."),".bpxa24fc5");
}

test();
