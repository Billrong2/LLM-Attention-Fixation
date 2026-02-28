function f(text: string): string {
    const new_text = text.split('').map(c => c.match(/\d/) ? c : '*');
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("5f83u23saa"),"5*83*23***");
}

test();
