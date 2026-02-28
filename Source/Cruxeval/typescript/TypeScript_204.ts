function f(name: string): string[] {
    return [name[0], name[1].split('').reverse()[0]];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("master. "),["m", "a"]);
}

test();
