function f(values, text, markers){
    return text.replace(new RegExp(`[${values}]+$`, 'g'), '').replace(new RegExp(`^[${markers}]+`, 'g'), '');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("2Pn", "yCxpg2C2Pny2", ""),"yCxpg2C2Pny");
}

test();
