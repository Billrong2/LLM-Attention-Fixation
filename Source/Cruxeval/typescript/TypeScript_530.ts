function f(s: string, ch: string): string {
    let sl: string = s;
    if (s.includes(ch)) {
        sl = s.replace(new RegExp('^' + ch + '+'), '');
        if (sl.length === 0) {
            sl = sl + '!?';
        }
    } else {
        return 'no';
    }
    return sl;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("@@@ff", "@"),"ff");
}

test();
