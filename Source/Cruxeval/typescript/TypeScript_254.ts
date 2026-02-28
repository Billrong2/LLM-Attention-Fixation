function f(text: string, repl: string): string {
    const trans = text.toLowerCase().split('').reduce((acc, curr, index) => {
        acc[curr] = repl[index] || '';
        return acc;
    }, {});
    return text.split('').map(char => trans[char] || char).join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("upper case", "lower case"),"lwwer case");
}

test();
