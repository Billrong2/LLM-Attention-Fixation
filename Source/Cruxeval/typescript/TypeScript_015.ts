function f(text: string, wrong: string, right: string): string {
    let new_text: string = text.replace(wrong, right);
    return new_text.toUpperCase();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("zn kgd jw lnt", "h", "u"),"ZN KGD JW LNT");
}

test();
