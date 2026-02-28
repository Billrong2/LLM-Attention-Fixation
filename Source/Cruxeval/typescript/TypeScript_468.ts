function f(a: string, b: string, n: number): string {
    let result: string = b;
    let m: string = b;
    for (let _ = 0; _ < n; _++) {
        if (m) {
            [a, m] = [a.replace(m, ''), null];
            result = m = b;
        }
    }
    return a.split(b).join(result);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("unrndqafi", "c", 2),"unrndqafi");
}

test();
