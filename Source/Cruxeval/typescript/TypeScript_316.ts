function f(name: string): string {
    return '| ' + name.split(' ').join(' ') + ' |';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("i am your father"),"| i am your father |");
}

test();
