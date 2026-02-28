function f(values: string, text: string, markers: string): string {
    return text.replace(new RegExp(`[${values}${markers}]*$`), '');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("2Pn", "yCxpg2C2Pny2", ""),"yCxpg2C2Pny");
}

test();
