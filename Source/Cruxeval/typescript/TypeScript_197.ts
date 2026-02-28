function f(temp: number, timeLimit: number): string {
    const s: number = Math.floor(timeLimit / temp);
    const e: number = timeLimit % temp;
    return [`${e} oC`, `${s} ${e}`][s > 1 ? 1 : 0];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(1, 1234567890),"1234567890 0");
}

test();
