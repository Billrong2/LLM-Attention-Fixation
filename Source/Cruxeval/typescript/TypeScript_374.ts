function f(seq: string[], v: string): string[] {
    const a: string[] = [];
    seq.forEach(i => {
        if (i.endsWith(v)) {
            a.push(i.repeat(2));
        }
    });
    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["oH", "ee", "mb", "deft", "n", "zz", "f", "abA"], "zz"),["zzzz"]);
}

test();
