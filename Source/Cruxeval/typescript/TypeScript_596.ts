function f(txt: string[], alpha: string): string[] {
    txt.sort();
    if (txt.indexOf(alpha) % 2 === 0) {
        return txt.reverse();
    }
    return txt;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["8", "9", "7", "4", "3", "2"], "9"),["2", "3", "4", "7", "8", "9"]);
}

test();
