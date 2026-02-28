function f(dictionary: {[key: number]: number}): {[key: string]: number} {
    const a: {[key: string]: number} = {...dictionary};
    for (const key in a) {
        if (parseInt(key) % 2 !== 0) {
            delete a[key];
            a['$' + key] = a[key];
        }
    }
    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}),{});
}

test();
