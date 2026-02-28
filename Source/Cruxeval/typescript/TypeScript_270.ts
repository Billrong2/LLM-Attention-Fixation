function f(dic: {[key: number]: number}): {[key: number]: number} {
    let d: {[key: number]: number} = {};
    let keys = Object.keys(dic).map(Number);
    keys.sort((a, b) => a - b);
    while(keys.length) {
        let key = keys.shift();
        if(key !== undefined) {
            d[key] = dic[key];
            delete dic[key];
        }
    }
    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
