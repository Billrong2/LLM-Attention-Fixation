function f(text: string): boolean {
    const length: number = text.length;
    const half: number = Math.floor(length / 2);
    const encode: Uint8Array = new TextEncoder().encode(text.substring(0, half));
    
    if (text.substring(half) === new TextDecoder().decode(encode)) {
        return true;
    } else {
        return false;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("bbbbr"),false);
}

test();
