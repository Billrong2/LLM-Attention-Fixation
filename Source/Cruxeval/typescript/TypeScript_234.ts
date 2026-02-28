function f(text: string, char: string): number {
    let position: number = text.length;
    if (text.includes(char)) {
        position = text.indexOf(char);
        if (position > 1) {
            position = (position + 1) % text.length;
        }
    }
    return position;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wduhzxlfk", "w"),0);
}

test();
