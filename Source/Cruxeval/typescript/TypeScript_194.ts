function f(matr: number[][], insert_loc: number): number[][] {
    matr.splice(insert_loc, 0, []);
    return matr;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[5, 6, 2, 3], [1, 9, 5, 6]], 0),[[], [5, 6, 2, 3], [1, 9, 5, 6]]);
}

test();
