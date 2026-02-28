function f(matrix: number[][]): number[][] {
    matrix.reverse();
    let result: number[][] = [];
    for (let primary of matrix) {
        Math.max(...primary);
        primary.sort((a, b) => b - a);
        result.push(primary);
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[1, 1, 1, 1]]),[[1, 1, 1, 1]]);
}

test();
