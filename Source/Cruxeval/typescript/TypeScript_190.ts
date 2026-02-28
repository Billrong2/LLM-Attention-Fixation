function f(text: string): string {
  let short: string = '';
  for (let c of text) {
    if (c === c.toLowerCase() && c !== c.toUpperCase()) {
      short += c;
    }
  }
  return short;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("980jio80jic kld094398IIl "),"jiojickldl");
}

test();
