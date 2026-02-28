function f(text: string): string {
    for (let space of text) {
        if (space === ' ') {
            text = text.trimLeft();
        } else {
            text = text.replace('cd', space);
        }
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("lorem ipsum"),"lorem ipsum");
}

test();
