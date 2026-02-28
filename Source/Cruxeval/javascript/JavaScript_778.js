function f(prefix, text){
    if (text.startsWith(prefix)) {
        return text;
    } else {
        return prefix + text;
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mjs", "mjqwmjsqjwisojqwiso"),"mjsmjqwmjsqjwisojqwiso");
}

test();
