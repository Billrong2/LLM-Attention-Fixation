function f(s: string, ch: string): string {
    if (s.indexOf(ch) === -1) {
        return '';
    }
    let result = '';
    let temp = s;
    while (temp.includes(ch)) {
        temp = temp.split(ch)[1].split('').reverse().join('');
        result = temp;
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("shivajimonto6", "6"),"");
}

test();
