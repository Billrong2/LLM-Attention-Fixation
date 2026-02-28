function f(txt: string, sep: string, sep_count: number): string {
    let o: string = '';
    while (sep_count > 0 && txt.split(sep).length > 1) {
        o += txt.split(sep).slice(0, -1).join(sep) + sep;
        txt = txt.split(sep).pop();
        sep_count--;
    }
    return o + txt;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("i like you", " ", -1),"i like you");
}

test();
