function f(file) {
    return file.indexOf('\n');
}

const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(`n wez szize lnson tilebi it 504n.
`),33);
}

test();
