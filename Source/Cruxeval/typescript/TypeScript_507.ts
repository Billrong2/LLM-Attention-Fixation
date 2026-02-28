function f(text: string, search: string): number {
    let result: string = text.toLowerCase();
    return result.indexOf(search.toLowerCase());
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("car hat", "car"),0);
}

test();
