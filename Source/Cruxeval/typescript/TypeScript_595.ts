function f(text: string, prefix: string): string {
    if (text.startsWith(prefix)) {
        text = text.substring(prefix.length);
    }
    text = text.charAt(0).toUpperCase() + text.slice(1);
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qdhstudentamxupuihbuztn", "jdm"),"Qdhstudentamxupuihbuztn");
}

test();
