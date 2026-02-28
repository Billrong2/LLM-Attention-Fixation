function f(text: string): string {
    let result: string = '';
    let i: number = text.length - 1;
    while (i >= 0) {
        let c: string = text[i];
        if (c.match(/[a-zA-Z]/)) {
            result += c;
        }
        i -= 1;
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("102x0zoq"),"qozx");
}

test();
