function f(text: string, size: number): string {
    let counter: number = text.length;
    for(let i = 0; i < size - size % 2; i++) {
        text = ' ' + text + ' ';
        counter += 2;
        if (counter >= size) {
            return text;
        }
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("7", 10),"     7     ");
}

test();
