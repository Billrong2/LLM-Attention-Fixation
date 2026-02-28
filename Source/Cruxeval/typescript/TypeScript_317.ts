function f(text: string, a: string, b: string): string {
    text = text.replace(new RegExp(a, 'g'), b);
    return text.replace(new RegExp(b, 'g'), a);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(" vup a zwwo oihee amuwuuw! ", "a", "u")," vap a zwwo oihee amawaaw! ");
}

test();
