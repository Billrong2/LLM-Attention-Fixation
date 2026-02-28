function f(text: string, sub: string): number {
    let a:number = 0;
    let b:number = text.length - 1;

    while (a <= b) {
        let c:number = Math.floor((a + b) / 2);
        if (text.lastIndexOf(sub) >= c) {
            a = c + 1;
        } else {
            b = c - 1;
        }
    }

    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dorfunctions", "2"),0);
}

test();
