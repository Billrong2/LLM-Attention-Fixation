function f(array: (string | number)[]): (string | number)[] {
    const result: (string | number)[] = [];
    for (const elem of array) {
        if (typeof elem === 'string' || (typeof elem === 'number' && Math.abs(elem).toString().charCodeAt(0) < 128)) {
            result.push(elem);
        }
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["a", "b", "c"]),["a", "b", "c"]);
}

test();
