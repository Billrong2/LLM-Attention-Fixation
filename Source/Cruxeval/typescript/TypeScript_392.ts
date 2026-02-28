function f(text: string): string {
    if (text.toUpperCase() === text) {
        return 'ALL UPPERCASE';
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Hello Is It MyClass"),"Hello Is It MyClass");
}

test();
