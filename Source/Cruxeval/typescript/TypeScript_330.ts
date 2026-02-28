function f(text: string): string {
    let ans: string[] = [];
    for (let char of text) {
        if (char >= '0' && char <= '9') {
            ans.push(char);
        } else {
            ans.push(' ');
        }
    }
    return ans.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("m4n2o")," 4 2 ");
}

test();
