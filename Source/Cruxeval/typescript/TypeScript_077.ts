function f(text: string, character: string): string {
    const subject = text.substring(text.lastIndexOf(character));
    return subject.repeat(text.split(character).length - 1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("h ,lpvvkohh,u", "i"),"");
}

test();
