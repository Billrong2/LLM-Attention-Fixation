function f(text: string): string {
    let letters = '';
    for(let i = 0; i < text.length; i++) {
        if(text[i].match(/^[0-9a-zA-Z]+$/)) {
            letters += text[i];
        }
    }
    return letters;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("we@32r71g72ug94=(823658*!@324"),"we32r71g72ug94823658324");
}

test();
