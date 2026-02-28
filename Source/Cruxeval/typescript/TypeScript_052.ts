function f(text: string): string {
    let a: string[] = [];
    for (let i = 0; i < text.length; i++) {
        if (!text[i].match(/\d/)) {
            a.push(text[i]);
        }
    }
    return a.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("seiq7229 d27"),"seiq d");
}

test();
