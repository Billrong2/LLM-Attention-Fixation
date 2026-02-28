function f(text){
    let a = 0;
    if (text[0] && text.slice(1).includes(text[0])) {
        a += 1;
    }
    for (let i = 0; i < text.length - 1; i++) {
        if (text[i] && text.slice(i + 1).includes(text[i])) {
            a += 1;
        }
    }
    return a;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("3eeeeeeoopppppppw14film3oee3"),18);
}

test();
