function f(text: string, position: number): string {
    const length: number = text.length;
    let index: number = position % (length + 1);
    if (position < 0 || index < 0) {
        index = -1;
    }
    const new_text: string[] = text.split('');
    new_text.splice(index, 1);
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("undbs l", 1),"udbs l");
}

test();
