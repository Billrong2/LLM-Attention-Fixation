function f(text, suffix){
    if(suffix.startsWith("/")){
        return text + suffix.substring(1);
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("hello.txt", "/"),"hello.txt");
}

test();
