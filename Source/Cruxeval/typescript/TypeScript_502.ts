function f(name: string): string {
    return name.split(' ').join('*');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Fred Smith"),"Fred*Smith");
}

test();
