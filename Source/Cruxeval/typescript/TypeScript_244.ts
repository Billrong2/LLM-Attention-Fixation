function f(text: string, symbols: string): string {
    let count: number = 0;
    if (symbols) {
        for (let i of symbols) {
            count += 1;
        }
        text = text.repeat(count);
    }
    return text.padStart(text.length + count*2).slice(0, -2);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("", "BC1ty"),"        ");
}

test();
