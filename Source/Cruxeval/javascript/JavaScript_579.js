function f(text){
    if (text.charAt(0).toUpperCase() + text.slice(1) === text) {
        if (text.length > 1 && text.toLowerCase() !== text) {
            return text.charAt(0).toLowerCase() + text.slice(1);
        }
    } else if (text.match(/^[A-Za-z]+$/)) {
        return text.charAt(0).toUpperCase() + text.slice(1).toLowerCase();
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(""),"");
}

test();
