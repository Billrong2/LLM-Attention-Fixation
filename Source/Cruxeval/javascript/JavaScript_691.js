function f(text, suffix) {
    if (suffix && text.includes(suffix[suffix.length - 1])) {
        return f(text.replace(new RegExp(suffix[suffix.length - 1] + '+$'), ''), suffix.slice(0, -1));
    } else {
        return text;
    }
}

const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("rpyttc", "cyt"),"rpytt");
}

test();
