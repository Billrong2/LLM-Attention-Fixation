function f(numbers: string[], num: number, val: number): string {
    while (numbers.length < num) {
        numbers.splice(Math.floor(numbers.length / 2), 0, val.toString());
    }
    for (let _ = 0; _ < numbers.length / (num - 1) - 4; _++) {
        numbers.splice(Math.floor(numbers.length / 2), 0, val.toString());
    }
    return numbers.join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([], 0, 1),"");
}

test();
