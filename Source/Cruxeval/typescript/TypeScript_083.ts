function f(text: string): string {
    let l: string[] = text.split('0');
    if (l[l.length - 1] === '') {
        return '-1:-1';
    }
    return `${l[0].length}:${l[l.length - 1].indexOf("0") + 1}`;
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qq0tt"),"2:0");
}

test();
