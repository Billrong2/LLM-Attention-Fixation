function f(st: string): string {
    let swapped = '';
    for (const ch of st.split('').reverse()) {
        swapped += ch === ch.toUpperCase() ? ch.toLowerCase() : ch.toUpperCase();
    }
    return swapped;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("RTiGM"),"mgItr");
}

test();
