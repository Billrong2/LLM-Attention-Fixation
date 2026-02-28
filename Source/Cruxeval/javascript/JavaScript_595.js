function f(text, prefix){
    let newText = text;
    if (newText.startsWith(prefix)) {
        newText = newText.substring(prefix.length);
    }
    newText = newText.charAt(0).toUpperCase() + newText.slice(1);
    return newText;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qdhstudentamxupuihbuztn", "jdm"),"Qdhstudentamxupuihbuztn");
}

test();
