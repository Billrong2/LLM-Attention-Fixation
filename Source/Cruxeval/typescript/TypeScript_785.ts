function f(n: number): string {
    let streak: string = '';
    for (const c of n.toString()) {
        streak += c.padEnd(parseInt(c) * 2);
    }
    return streak;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(1),"1 ");
}

test();
