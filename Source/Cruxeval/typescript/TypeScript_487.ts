function f(dict: {[key: number]: string}): number[] {
    const even_keys: number[] = [];
    for (const key in dict) {
        if (parseInt(key) % 2 === 0) {
            even_keys.push(parseInt(key));
        }
    }
    return even_keys;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({4: "a"}),[4]);
}

test();
