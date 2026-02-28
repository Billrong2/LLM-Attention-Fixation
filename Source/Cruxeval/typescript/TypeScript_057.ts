function f(text: string): number | string {
    text = text.toUpperCase();
    let count_upper = 0;
    for (let char of text) {
        if (char === char.toUpperCase()) {
            count_upper++;
        } else {
            return 'no';
        }
    }
    return Math.floor(count_upper / 2);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ax"),1);
}

test();
