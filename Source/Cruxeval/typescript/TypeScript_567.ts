function f(s: string, n: number): string[] {
    let ls: string[] = s.split(' ');
    let out: string[] = [];
    while (ls.length >= n) {
        out = ls.splice(-n).concat(out);
    }
    return ls.concat(out.join('_'));
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("one two three four five", 3),["one", "two", "three_four_five"]);
}

test();
