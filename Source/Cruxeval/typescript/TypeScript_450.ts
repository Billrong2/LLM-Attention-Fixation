function f(strs: string): string {
    let words = strs.split(" ");
    for (let i = 1; i < words.length; i += 2) {
        words[i] = words[i].split("").reverse().join("");
    }
    return words.join(" ");
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("K zBK"),"K KBz");
}

test();
