function f(string: string): string {
    if (string.substring(0, 4) !== 'Nuva') {
        return 'no';
    } else {
        return string.trimRight();
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Nuva?dlfuyjys"),"Nuva?dlfuyjys");
}

test();
