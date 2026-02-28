function f(text: string): string {
    if (/^\d+$/.test(text)) {
        return 'integer';
    }
    return 'string';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(""),"string");
}

test();
