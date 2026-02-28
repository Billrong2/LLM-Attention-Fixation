function f(n: number, array: number[]): number[][] {
    let final: number[][] = [array.slice()];
    for (let i = 0; i < n; i++) {
        let arr: number[] = array.slice();
        arr.push(...final[final.length - 1]);
        final.push(arr);
    }
    return final;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(1, [1, 2, 3]),[[1, 2, 3], [1, 2, 3, 1, 2, 3]]);
}

test();
