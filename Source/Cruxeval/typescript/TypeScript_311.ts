function f(text: string): string {
    text = text.replace('#', '1').replace('$', '5');
    return text.match(/^\d+$/) ? 'yes' : 'no';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("A"),"no");
}

test();
