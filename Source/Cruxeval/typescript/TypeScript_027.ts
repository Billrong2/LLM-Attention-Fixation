function f(w: string): boolean {
    let ls: string[] = w.split('');
    let omw: string = '';
    while (ls.length > 0) {
        omw += ls.shift()!;
        if (ls.length * 2 > w.length) {
            return w.slice(ls.length) === omw;
        }
    }
    return false;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("flak"),false);
}

test();
