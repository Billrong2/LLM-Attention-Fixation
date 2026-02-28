function f(start: number, end: number, interval: number): number {
    const steps: number[] = Array.from({ length: Math.ceil((end - start) / interval) + 1 }, (_, index) => start + interval * index);
    if (steps.includes(1)) {
        steps[steps.length - 1] = end + 1;
    }
    return steps.length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(3, 10, 1),8);
}

test();
