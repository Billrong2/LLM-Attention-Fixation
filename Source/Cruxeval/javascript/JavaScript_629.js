function f(text, dng){
    if (!text.includes(dng)){
        return text;
    }
    if (text.slice(-dng.length) === dng){
        return text.slice(0, -dng.length);
    }
    return text.slice(0, -1) + f(text.slice(0, -2), dng);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("catNG", "NG"),"cat");
}

test();
