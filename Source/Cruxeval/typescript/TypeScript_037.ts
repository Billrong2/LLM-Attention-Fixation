function f(text: string): string[] {
    let text_arr: string[] = [];
    for (let j = 0; j < text.length; j++) {
        text_arr.push(text.substring(j));
    }
    return text_arr;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("123"),["123", "23", "3"]);
}

test();
