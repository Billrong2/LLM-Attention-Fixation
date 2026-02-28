function f(text: string, to_remove: string): string {
    let new_text = text.split('');
    if (new_text.includes(to_remove)) {
        let index = new_text.indexOf(to_remove);
        new_text[index] = '?';
        new_text.splice(index, 1);
    }
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("sjbrlfqmw", "l"),"sjbrfqmw");
}

test();
