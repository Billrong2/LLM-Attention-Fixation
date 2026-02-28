function f(text: string): number {
    let a: number = text.length;
    let count: number = 0;
    while (text) {
        if (text.startsWith('a')) {
            count += text.indexOf(' ');
        } else {
            count += text.indexOf('\n');
        }
        text = text.substring(text.indexOf('\n')+1, text.indexOf('\n')+a+1);
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a\nkgf\nasd\n"),1);
}

test();
