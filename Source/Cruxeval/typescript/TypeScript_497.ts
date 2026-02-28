function f(n: number): string[] {
    let b: string[] = n.toString().split('');
    for (let i = 2; i < b.length; i++) {
        b[i] += '+';
    }
    return b;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(44),["4", "4"]);
}

test();
