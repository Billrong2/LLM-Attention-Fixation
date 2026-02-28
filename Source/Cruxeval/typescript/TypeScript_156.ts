function f(text: string, limit: number, char: string): string {
    if (limit < text.length) {
        return text.substring(0, limit);
    }
    return text.padEnd(limit, char);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("tqzym", 5, "c"),"tqzym");
}

test();
