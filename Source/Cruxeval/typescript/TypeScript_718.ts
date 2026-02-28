function f(text: string): string {
    let t: string = text;
    for (let i of text) {
        text = text.replace(i, '');
    }
    return text.length.toString() + t;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ThisIsSoAtrocious"),"0ThisIsSoAtrocious");
}

test();
