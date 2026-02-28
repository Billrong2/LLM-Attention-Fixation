function f(text: string): number {
    let counter: number = 0;
    for (let char of text) {
        if (char.match(/[a-zA-Z]/)) {
            counter++;
        }
    }
    return counter;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("l000*"),1);
}

test();
