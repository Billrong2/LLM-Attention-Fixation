function f(address){
    let suffix_start = address.indexOf('@') + 1;
    if (address.substring(suffix_start).split('.').length > 2) {
        let parts = address.split('@')[1].split('.').slice(0, 2);
        address = address.replace('.' + parts.join('.'), '');
    }
    return address;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("minimc@minimc.io"),"minimc@minimc.io");
}

test();
