function f(text: string, use: string): string {
    return text.replace(new RegExp(use, 'g'), '');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Chris requires a ride to the airport on Friday.", "a"),"Chris requires  ride to the irport on Fridy.");
}

test();
