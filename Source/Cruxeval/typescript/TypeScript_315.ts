function f(challenge: string): string {
    return challenge.toLowerCase().replace('l', ',');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("czywZ"),"czywz");
}

test();
