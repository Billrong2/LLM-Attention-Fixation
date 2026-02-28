function f(text: string): boolean {
    return /^[\x00-\x7F]*$/.test(text);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct"),false);
}

test();
