function f(text: string): string {
    let ls: string[] = text.split('');
    let total: number = (text.length - 1) * 2;
    for (let i = 1; i <= total; i++) {
        if (i % 2) {
            ls.push('+');
        } else {
            ls.unshift('+');
        }
    }
    return ls.join('').padStart(total);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("taole"),"++++taole++++");
}

test();
