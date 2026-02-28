function f(text, char){
    var count = text.split(char+char).length - 1;
    return text.slice(count);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("vzzv2sg", "z"),"zzv2sg");
}

test();
