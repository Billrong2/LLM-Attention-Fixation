function f(total: string[], arg: string): string[] {
    if (Array.isArray(arg)) {
        for (let e of arg) {
            total.push(...e);
        }
    } else {
        total.push(...arg);
    }
    return total;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["1", "2", "3"], "nammo"),["1", "2", "3", "n", "a", "m", "m", "o"]);
}

test();
