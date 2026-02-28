function f(address: string): string {
    let suffix_start = address.indexOf('@') + 1;
    if (address.substring(suffix_start).split('.').length > 2) {
        address = address.replace(/@[^\@]*\.[^\@]*\./, '');
    }
    return address;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("minimc@minimc.io"),"minimc@minimc.io");
}

test();
