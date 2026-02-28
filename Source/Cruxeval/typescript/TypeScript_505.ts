function f(string: string): string {
    while (string) {
        if (string[string.length - 1].match(/[a-zA-Z]/)) {
            return string;
        }
        string = string.slice(0, -1);
    }
    return string;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("--4/0-209"),"");
}

test();
