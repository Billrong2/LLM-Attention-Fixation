function f(bag: {[key: number]: number}): {[key: number]: number} {
    const values = Object.values(bag);
    const tbl: {[key: number]: number} = {};
    for (let v = 0; v < 100; v++) {
        if (values.includes(v)) {
            tbl[v] = values.filter(val => val === v).length;
        }
    }
    return tbl;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({0: 0, 1: 0, 2: 0, 3: 0, 4: 0}),{0: 5});
}

test();
