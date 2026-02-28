function f(s: string, from_c: string, to_c: string): string {
    const table = new Map<string, string>();
    for (let i = 0; i < from_c.length; i++) {
        table.set(from_c[i], to_c[i]);
    }

    let result = '';
    for (let char of s) {
        result += table.has(char) ? table.get(char) : char;
    }

    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("aphid", "i", "?"),"aph?d");
}

test();
