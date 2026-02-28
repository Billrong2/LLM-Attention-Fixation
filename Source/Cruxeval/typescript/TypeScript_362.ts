function f(text: string): string {
    for (let i = 0; i < text.length-1; i++) {
        if (text.slice(i).toLowerCase() === text.slice(i)) {
            return text.slice(i+1);
        }
    }
    return '';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wrazugizoernmgzu"),"razugizoernmgzu");
}

test();
