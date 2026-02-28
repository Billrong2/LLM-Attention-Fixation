function f(array: number[], elem: number): number {
    const strElem: string = elem.toString();
    let d: number = 0;
    array.forEach(i => {
        if (i.toString() === strElem) {
            d += 1;
        }
    });
    return d;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([-1, 2, 1, -8, -8, 2], 2),2);
}

test();
