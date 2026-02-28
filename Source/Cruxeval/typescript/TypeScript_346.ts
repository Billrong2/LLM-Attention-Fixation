function f(filename: string): boolean {
    const suffix: string = filename.split('.').pop();
    const f2: string = filename + suffix.split('').reverse().join('');
    return f2.endsWith(suffix);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("docs.doc"),false);
}

test();
