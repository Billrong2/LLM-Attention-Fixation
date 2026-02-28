function f(title: string): string {
    return title.toLowerCase();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("   Rock   Paper   SCISSORS  "),"   rock   paper   scissors  ");
}

test();
