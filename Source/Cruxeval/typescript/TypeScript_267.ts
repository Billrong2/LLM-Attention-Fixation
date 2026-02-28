function f(text: string, space: number): string {
    if (space < 0) {
        return text;
    }
    return text.padEnd(Math.floor(text.length / 2) + space);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("sowpf", -7),"sowpf");
}

test();
