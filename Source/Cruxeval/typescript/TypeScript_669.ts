function f(t: string): string {
    let [a, sep, b] = t.split('-');
    if (b === undefined) {
        b = a;
        a = '';
        sep = '';
    }
    if (b.length == a.length) {
        return 'imbalanced';
    }
    return a + b.replace(sep, '');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("fubarbaz"),"fubarbaz");
}

test();
