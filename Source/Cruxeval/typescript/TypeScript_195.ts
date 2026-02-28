function f(text: string): string {
    const prefixes = ['acs', 'asp', 'scn'];
    for (const p of prefixes) {
        text = text.replace(new RegExp('^' + p), '') + ' ';
    }
    return text.replace(/^\s+/, '').slice(0, -1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ilfdoirwirmtoibsac"),"ilfdoirwirmtoibsac  ");
}

test();
