function f(value: string): string {
    const parts = value.split(' ').filter((_, index) => index % 2 === 0);
    return parts.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("coscifysu"),"coscifysu");
}

test();
