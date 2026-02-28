function f(text: string): string {
    return text.split(' ').map(word => word.trim()).join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("pvtso"),"pvtso");
}

test();
