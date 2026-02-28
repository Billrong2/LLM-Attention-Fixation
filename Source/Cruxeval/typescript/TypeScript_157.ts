function f(phrase: string): number {
    let ans: number = 0;
    phrase.split(' ').forEach(word => {
        for (let i = 0; i < word.length; i++) {
            if (word[i] === "0") {
                ans++;
            }
        }
    });
    return ans;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("aboba 212 has 0 digits"),1);
}

test();
