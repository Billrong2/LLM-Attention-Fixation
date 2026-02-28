function f(text: string, count: number): string {
    for (let i = 0; i < count; i++) {
        text = text.split('').reverse().join('');
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("439m2670hlsw", 3),"wslh0762m934");
}

test();
