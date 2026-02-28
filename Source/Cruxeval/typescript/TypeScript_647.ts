function f(text: string, chunks: number): string[] {
    return text.split('\n');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("/alcm@ an)t//eprw)/e!/d\nujv", 0),["/alcm@ an)t//eprw)/e!/d", "ujv"]);
}

test();
