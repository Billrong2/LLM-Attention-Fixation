function f(sentences: string): string {
    if (sentences.split('.').every(sentence => !isNaN(Number(sentence)))) {
        return 'oscillating';
    } else {
        return 'not oscillating';
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("not numbers"),"not oscillating");
}

test();
