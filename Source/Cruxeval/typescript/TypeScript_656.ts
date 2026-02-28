function f(letters: string[]): string {
    let a: string[] = [];
    for (let i = 0; i < letters.length; i++) {
        if (a.includes(letters[i])) {
            return 'no';
        }
        a.push(letters[i]);
    }
    return 'yes';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["b", "i", "r", "o", "s", "j", "v", "p"]),"yes");
}

test();
