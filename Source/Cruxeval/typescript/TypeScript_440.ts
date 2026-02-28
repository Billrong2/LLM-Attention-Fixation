function f(text: string): string {
    if (text.match(/^\d+$/)) {
        return 'yes';
    } else {
        return 'no';
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abc"),"no");
}

test();
