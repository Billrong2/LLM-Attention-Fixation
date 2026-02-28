function f(text: string): string {
    let lowercase = text.toLowerCase();
    let capitalize = lowercase.charAt(0).toUpperCase() + lowercase.slice(1);
    return lowercase.charAt(0) + capitalize.slice(1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("this And cPanel"),"this and cpanel");
}

test();
