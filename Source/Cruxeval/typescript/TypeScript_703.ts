function f(text: string, char: string): string {
    const count: number = text.match(new RegExp(char.repeat(2), 'g'))?.length || 0;
    return text.slice(count);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("vzzv2sg", "z"),"zzv2sg");
}

test();
