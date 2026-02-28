function f(text: string, fill: string, size: number): string {
    if (size < 0) {
        size = -size;
    }
    if (text.length > size) {
        return text.substring(text.length - size);
    }
    return text.padStart(size, fill);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("no asw", "j", 1),"w");
}

test();
