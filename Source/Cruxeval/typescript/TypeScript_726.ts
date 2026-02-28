function f(text: string): [number, number] {
    let ws = 0;
    for(let s of text) {
        if (s.trim().length === 0) {
            ws += 1;
        }
    }
    return [ws, text.length];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("jcle oq wsnibktxpiozyxmopqkfnrfjds"),[2, 34]);
}

test();
