function f(concat: string, di: {[key: string]: string}): string {
    const keys = Object.keys(di);
    const count = keys.length;
    for (let i = 0; i < count; i++) {
        if (di[keys[i]] && concat.includes(di[keys[i]])) {
            delete di[keys[i]];
        }
    }
    return "Done!";
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mid", {"0": "q", "1": "f", "2": "w", "3": "i"}),"Done!");
}

test();
