function f(text: string, count: number): string {
    for(let i = 0; i < count; i++) {
        text = text.split('').reverse().join('');
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("aBc, ,SzY", 2),"aBc, ,SzY");
}

test();
