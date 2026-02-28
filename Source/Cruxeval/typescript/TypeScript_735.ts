function f(sentence: string): string {
    if (sentence === '') {
        return '';
    }
    sentence = sentence.replace(/\(/g, '');
    sentence = sentence.replace(/\)/g, '');
    sentence = sentence.replace(/ /g, '');
    return sentence.charAt(0).toUpperCase() + sentence.slice(1).toLowerCase();
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("(A (b B))"),"Abb");
}

test();
