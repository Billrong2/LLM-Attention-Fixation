function f(n: number, m: number, num: number): number {
    const x_list: number[] = Array.from({length: m - n + 1}, (_, index) => n + index);
    let j: number = 0;
    while (true) {
        j = (j + num) % x_list.length;
        if (x_list[j] % 2 === 0) {
            return x_list[j];
        }
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(46, 48, 21),46);
}

test();
