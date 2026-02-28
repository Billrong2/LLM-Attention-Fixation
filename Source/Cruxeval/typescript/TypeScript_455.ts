function f(text: string): string {
    let uppers: number = 0;
    for (let c of text) {
        if (c === c.toUpperCase()) {
            uppers += 1;
        }
    }
    return uppers >= 10 ? text.toUpperCase() : text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("?XyZ"),"?XyZ");
}

test();
