function f(cart: {[key: number]: number}): {[key: number]: number} {
    while(Object.keys(cart).length > 5) {
        delete cart[Object.keys(cart)[0]];
    }
    return cart;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
