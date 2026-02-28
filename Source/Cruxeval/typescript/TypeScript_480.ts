function f(s: string, c1: string, c2: string): string {
    if (s === '') {
        return s;
    }
    let ls: string[] = s.split(c1);
    for (let index in ls) {
        let item = ls[index];
        if (item.includes(c1)) {
            ls[index] = item.replace(c1, c2);
        }
    }
    return ls.join(c1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("", "mi", "siast"),"");
}

test();
