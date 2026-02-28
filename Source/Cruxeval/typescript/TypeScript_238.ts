function f(ls: number[][], n: number): number[]| number {
    let answer: number|number[] = 0;
    ls.forEach(i => {
        if (i[0] === n) {
            answer = i;
        }
    });
    return answer;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[1, 9, 4], [83, 0, 5], [9, 6, 100]], 1),[1, 9, 4]);
}

test();
