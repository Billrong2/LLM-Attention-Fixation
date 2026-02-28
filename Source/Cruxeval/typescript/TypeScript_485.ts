function f(tokens: string): string {
    let tokensArr = tokens.split(' ');
    if (tokensArr.length === 2) {
        tokensArr.reverse();
    }
    let result = tokensArr[0].padEnd(5) + ' ' + tokensArr[1].padEnd(5);
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("gsd avdropj"),"avdropj gsd  ");
}

test();
