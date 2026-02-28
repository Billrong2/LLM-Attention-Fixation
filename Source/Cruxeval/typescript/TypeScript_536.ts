function f(cat: string): number {
    let digits: number = 0;
    for (let char of cat) {
        if (!isNaN(parseInt(char))) {
            digits += 1;
        }
    }
    return digits;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("C24Bxxx982ab"),5);
}

test();
