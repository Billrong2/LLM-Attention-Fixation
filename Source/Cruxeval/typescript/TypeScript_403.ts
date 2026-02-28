function f(full: string, part: string): number {
    let length: number = part.length;
    let index: number = full.indexOf(part);
    let count: number = 0;
    while (index >= 0) {
        full = full.substring(index + length);
        index = full.indexOf(part);
        count += 1;
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hrsiajiajieihruejfhbrisvlmmy", "hr"),2);
}

test();
