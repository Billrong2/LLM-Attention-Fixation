function f(text: string): boolean {
    let b: boolean = true;
    for (let x of text) {
        if (x >= '0' && x <= '9') {
            b = true;
        } else {
            b = false;
            break;
        }
    }
    return b;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("-1-3"),false);
}

test();
