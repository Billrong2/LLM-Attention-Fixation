function f(text: string, dng: string): string {
    if (text.indexOf(dng) === -1) {
        return text;
    }
    if (text.slice(-dng.length) === dng) {
        return text.slice(0, -dng.length);
    }
    return text.slice(0, -1) + f(text.slice(0, -2), dng);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("catNG", "NG"),"cat");
}

test();
