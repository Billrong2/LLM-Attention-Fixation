function f(text: string, letter: string): number {
    let counts: {[key: string]: number} = {};
    for (let char of text) {
        if (!counts[char]) {
            counts[char] = 1;
        } else {
            counts[char] += 1;
        }
    }
    return counts[letter] || 0;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("za1fd1as8f7afasdfam97adfa", "7"),2);
}

test();
