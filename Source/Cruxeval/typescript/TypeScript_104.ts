function f(text: string): {[key: string]: number} {
    const dic: {[key: string]: number} = {};
    for (const char of text) {
        dic[char] = dic[char] ? dic[char] + 1 : 1;
    }
    for (const key in dic) {
        if (dic[key] > 1) {
            dic[key] = 1;
        }
    }
    return dic;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a"),{"a": 1});
}

test();
