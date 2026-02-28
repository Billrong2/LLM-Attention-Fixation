function f(text: string, new_value: string, index: number): string {
    const key = text[index];
    const value = new_value;
    const result = text.replace(key, value);
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("spain", "b", 4),"spaib");
}

test();
