function f(text: string): string {
    return text.replace('Io', 'io').replace(/\b\w/g, (char) => char.toUpperCase());
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Fu,ux zfujijabji pfu."),"Fu,Ux Zfujijabji Pfu.");
}

test();
