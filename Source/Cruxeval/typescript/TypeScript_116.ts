function f(d: {[key: number]: number}, count: number): {[key: number]: number} {
    for(let i = 0; i < count; i++) {
        if (Object.keys(d).length === 0) {
            break;
        }
        delete d[Object.keys(d)[0]];
    }
    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({}, 200),{});
}

test();
