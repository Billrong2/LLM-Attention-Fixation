function f(text: string, suffix: string): string {
    if (suffix && text.includes(suffix[suffix.length - 1])) {
        return f(text.replace(new RegExp(suffix[suffix.length - 1] + '$'), ''), suffix.slice(0, -1));
    } else {
        return text;
    }
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("rpyttc", "cyt"),"rpytt");
}

test();
