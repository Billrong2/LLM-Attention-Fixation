function f(test: string, sep: string = ' ', maxsplit: number = -1): string[] {
    try {
        return test.split(sep, maxsplit);
    } catch {
        return test.split(' ');
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ab cd", "x", 2),["ab cd"]);
}

test();
