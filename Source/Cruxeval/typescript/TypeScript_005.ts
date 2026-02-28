function f(text: string, lower: string, upper: string): [number, string] {
    let count = 0;
    let new_text: string[] = [];
    for (let char of text) {
        char = (isNaN(parseInt(char)) ? upper : lower);
        if (['p', 'C'].includes(char)) {
            count += 1;
        }
        new_text.push(char);
    }
    return [count, new_text.join('')];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("DSUWeqExTQdCMGpqur", "a", "x"),[0, "xxxxxxxxxxxxxxxxxx"]);
}

test();
