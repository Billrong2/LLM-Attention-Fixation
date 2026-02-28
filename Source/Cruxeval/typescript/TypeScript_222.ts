function f(mess: string, char: string): string {
    while (mess.lastIndexOf(char) && mess.indexOf(char, mess.lastIndexOf(char) + 1) !== -1) {
        mess = mess.slice(0, mess.lastIndexOf(char) + 1) + mess.slice(mess.lastIndexOf(char) + 2);
    }
    return mess;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("0aabbaa0b", "a"),"0aabbaa0b");
}

test();
