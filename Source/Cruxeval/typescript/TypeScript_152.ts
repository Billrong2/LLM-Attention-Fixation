function f(text: string): number {
    let n = 0;
    for(let i=0; i<text.length; i++){
        if (text[i] === text[i].toUpperCase() && isNaN(parseInt(text[i]))) {
            n += 1;
        }
    }
    return n;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("AAAAAAAAAAAAAAAAAAAA"),20);
}

test();
