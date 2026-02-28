function f(text: string, value: string): string {
    const length: number = text.length;
    const letters: string[] = text.split('');
    if (!letters.includes(value)) {
        value = letters[0];
    }
    return value.repeat(length);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ldebgp o", "o"),"oooooooo");
}

test();
