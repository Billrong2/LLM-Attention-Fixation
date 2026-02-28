function f(doc: string): string {
    for (let x of doc) {
        if (x.match(/[a-zA-Z]/)) {
            return x.toUpperCase();
        }
    }
    return '-';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("raruwa"),"R");
}

test();
