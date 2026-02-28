function f(file: string): number {
    return file.indexOf('\n');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("n wez szize lnson tilebi it 504n.\n"),33);
}

test();
