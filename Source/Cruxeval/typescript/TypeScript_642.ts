function f(text: string): string {
    let i: number = 0;
    while (i < text.length && text[i].trim() === '') {
        i++;
    }
    if (i === text.length) {
        return 'space';
    }
    return 'no';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("     "),"space");
}

test();
