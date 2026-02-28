function f(text: string, x: string): string {
    if (!text.startsWith(x)) {
        return f(text.slice(1), x);
    }
    else {
        return text;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Ibaskdjgblw asdl ", "djgblw"),"djgblw asdl ");
}

test();
