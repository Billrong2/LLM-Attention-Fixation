function f(txt: string): string {
    let d: string[] = [];
    for (let c of txt) {
        if (c.match(/\d/)) {
            continue;
        }
        if (c === c.toLowerCase()) {
            d.push(c.toUpperCase());
        } else if (c === c.toUpperCase()) {
            d.push(c.toLowerCase());
        }
    }
    return d.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("5ll6"),"LL");
}

test();
