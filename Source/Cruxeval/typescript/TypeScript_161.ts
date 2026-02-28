function f(text: string, value: string): string {
    const index = text.indexOf(value);
    if (index === -1) {
        return text;
    }
    const left = text.slice(0, index);
    const right = text.slice(index + value.length);
    return right + left;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("difkj rinpx", "k"),"j rinpxdif");
}

test();
