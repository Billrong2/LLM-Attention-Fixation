function f(a: number): number[]| number {
    if (a === 0) {
        return [0];
    }
    let result: number[] = [];
    while (a > 0) {
        result.push(a % 10);
        a = Math.floor(a / 10);
    }
    result.reverse();
    return parseInt(result.join(''));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(0),[0]);
}

test();
