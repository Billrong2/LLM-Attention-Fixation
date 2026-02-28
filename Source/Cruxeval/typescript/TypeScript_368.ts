function f(string: string, numbers: number[]): string {
    const arr: string[] = [];
    numbers.forEach(num => {
        arr.push(string.padStart(num, '0'));
    });
    return arr.join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("4327", [2, 8, 9, 2, 7, 1]),"4327 00004327 000004327 4327 0004327 4327");
}

test();
