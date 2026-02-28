function f(text: string, char: string): number[] {
    let new_text: string = text;
    let a: number[] = [];
    while (new_text.includes(char)) {
        a.push(new_text.indexOf(char));
        new_text = new_text.replace(char, "");
    }
    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("rvr", "r"),[0, 1]);
}

test();
