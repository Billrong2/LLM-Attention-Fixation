function f(a: {[key: number]: string}): string {
    let s: {[key: number]: string} = {};
    Object.entries(a).reverse().forEach(([key, value]) => {
        s[Number(key)] = value;
    });
    return Object.entries(s).map(([key, value]) => `(${key}, '${value}')`).join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({15: "Qltuf", 12: "Rwrepny"}),"(12, 'Rwrepny') (15, 'Qltuf')");
}

test();
