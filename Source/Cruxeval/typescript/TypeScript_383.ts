function f(text: string, chars: string): string {
    let result: string[] = text.split('');
    while (chars === result.slice(-3)[0]) {
        result.pop();
        result.pop();
    }
    return result.join('').replace(/\.$/, '');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ellod!p.nkyp.exa.bi.y.hain", ".n.in.ha.y"),"ellod!p.nkyp.exa.bi.y.hain");
}

test();
