function f(string: string): string {
    let tmp: string = string.toLowerCase();
    for (let char of string.toLowerCase()) {
        if (tmp.includes(char)) {
            tmp = tmp.replace(char, '');
        }
    }
    return tmp;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("[ Hello ]+ Hello, World!!_ Hi"),"");
}

test();
