function f(text: string): string {
    return text.replace(/\n/g, '\t');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("apples\n	\npears\n	\nbananas"),"apples			pears			bananas");
}

test();
