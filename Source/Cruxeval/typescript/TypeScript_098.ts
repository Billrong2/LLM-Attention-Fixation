function f(s: string): number {
    return s.split(' ').filter(word => word.charAt(0) === word.charAt(0).toUpperCase() && word.slice(1) === word.slice(1).toLowerCase()).length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("SOME OF THIS Is uknowN!"),1);
}

test();
