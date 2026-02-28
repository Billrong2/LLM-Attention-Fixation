function f(text: string): string {
    let out = "";
    for (let i = 0; i < text.length; i++) {
        if (text[i].toUpperCase() === text[i]) {
            out += text[i].toLowerCase();
        } else {
            out += text[i].toUpperCase();
        }
    }
    return out;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(",wPzPppdl/"),",WpZpPPDL/");
}

test();
