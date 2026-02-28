function f(text: string): string {
    return text.split('').filter(x => x !== ')').join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("(((((((((((d))))))))).))))((((("),"(((((((((((d.(((((");
}

test();
