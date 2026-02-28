function f(d: {[key: string]: string}): [boolean, boolean] {
    let r: {[key: string]: {[key: string]: string}} = {
        'c': {...d},
        'd': {...d}
    };
    return [r['c'] === r['d'], JSON.stringify(r['c']) === JSON.stringify(r['d'])];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"i": "1", "love": "parakeets"}),[false, true]);
}

test();
