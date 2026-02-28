function f(text: string): number {
    let count: number = 0;
    for (let i of text) {
        if (i === '.' || i === '?' || i === '!' || i === ',' || i === '.') {
            count += 1;
        }
    }
    return count;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("bwiajegrwjd??djoda,?"),4);
}

test();
