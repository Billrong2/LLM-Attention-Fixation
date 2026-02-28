function f(text: string): string {
    if (text.split('').every(char => char.charCodeAt(0) < 128)) {
        return 'ascii';
    } else {
        return 'non ascii';
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("<<<<"),"ascii");
}

test();
