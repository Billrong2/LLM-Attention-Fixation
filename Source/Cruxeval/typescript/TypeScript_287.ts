function f(name: string): string {
    if (name === name.toLowerCase()) {
        return name.toUpperCase();
    } else {
        return name.toLowerCase();
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Pinneaple"),"pinneaple");
}

test();
