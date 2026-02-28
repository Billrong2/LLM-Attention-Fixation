function f(text: string): string {
    if (text.charAt(0) === text.charAt(0).toUpperCase() && text.slice(1) === text.slice(1).toLowerCase()) {
        return text.charAt(0).toLowerCase() + text.slice(1);
    } else if (text.match(/^[A-Za-z]+$/) !== null) {
        return text.charAt(0).toUpperCase() + text.slice(1).toLowerCase();
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(""),"");
}

test();
