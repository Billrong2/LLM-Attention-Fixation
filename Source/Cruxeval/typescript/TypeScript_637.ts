function f(text: string): string {
    let words = text.split(' ');
    for (let word of words) {
        if (!/^\d+$/.test(word)) {
            return 'no';
        }
    }
    return 'yes';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("03625163633 d"),"no");
}

test();
