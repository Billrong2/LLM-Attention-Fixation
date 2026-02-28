function f(text, char, min_count){
    var count = (text.match(new RegExp(char, "g")) || []).length;
    if (count < min_count) {
        return text.toUpperCase() === text ? text.toLowerCase() : text.toUpperCase();
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wwwwhhhtttpp", "w", 3),"wwwwhhhtttpp");
}

test();
