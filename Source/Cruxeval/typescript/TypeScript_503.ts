function f(d: {[key: number]: number}): number[] {
    let result: number[] = new Array(Object.keys(d).length);
    let a = 0, b = 0;
    while (Object.keys(d).length > 0) {
        let keys = Array.from(Object.keys(d));
        result[a] = parseInt(d[keys[b]]);
        delete d[keys[b]];
        a = b;
        b = (b + 1) % result.length;
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),[]);
}

test();
