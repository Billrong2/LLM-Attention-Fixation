function f(text: string, froms: string): string {
    let froms_arr = Array.from(froms);
    let text_arr = Array.from(text);
    while(froms_arr.includes(text_arr[0])) {
        text_arr.shift();
    }
    while(froms_arr.includes(text_arr[text_arr.length - 1])) {
        text_arr.pop();
    }
    return text_arr.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("0 t 1cos ", "st 0	\n  "),"1co");
}

test();
