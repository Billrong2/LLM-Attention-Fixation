function f(text: string, value: string): string {
    let ls: string[] = text.split('');
    if (ls.filter(v => v === value).length % 2 === 0) {
        while (ls.includes(value)) {
            ls.splice(ls.indexOf(value), 1);
        }
    } else {
        ls = [];
    }
    return ls.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abbkebaniuwurzvr", "m"),"abbkebaniuwurzvr");
}

test();
