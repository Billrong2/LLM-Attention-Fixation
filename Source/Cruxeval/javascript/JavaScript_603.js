function f(sentences){
    if(sentences.split('.').every(sentence => !isNaN(sentence.trim()))) {
        return 'oscillating';
    } else {
        return 'not oscillating';
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("not numbers"),"not oscillating");
}

test();
