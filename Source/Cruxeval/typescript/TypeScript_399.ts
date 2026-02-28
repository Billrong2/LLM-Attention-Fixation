function repeatString(str: string, numTimes: number): string {
    return new Array(numTimes + 1).join(str);
}

function f(text: string, old: string, newStr: string): string {
    if (old.length > 3) {
        return text;
    }
    if (text.includes(old) && !text.includes(' ')) {
        return text.replace(old, repeatString(newStr, old.length));
    }
    while (text.includes(old)) {
        text = text.replace(old, newStr);
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("avacado", "va", "-"),"a--cado");
}

test();
