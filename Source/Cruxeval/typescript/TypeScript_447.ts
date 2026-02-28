function f(text: string, tab_size: number): string {
    let res: string = '';
    text = text.replace('\t', ' '.repeat(tab_size - 1));
    for (let i = 0; i < text.length; i++) {
        if (text[i] === ' ') {
            res += '|';
        } else {
            res += text[i];
        }
    }
    return res;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("	a", 3),"||a");
}

test();
