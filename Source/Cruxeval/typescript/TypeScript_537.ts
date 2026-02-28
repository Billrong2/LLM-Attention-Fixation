function f(text: string, value: string): string {
    let new_text: string[] = Array.from(text);
    let length: number;
    try {
        new_text.push(value);
        length = new_text.length;
    } catch (e) {
        if (e instanceof RangeError) {
            length = 0;
        } else {
            throw e;
        }
    }
    return '[' + length.toString() + ']';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abv", "a"),"[4]");
}

test();
