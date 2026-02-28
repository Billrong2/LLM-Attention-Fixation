function f(array: number[], elem: number): number[] {
    let k: number = 0;
    let l: number[] = array.slice();
    for (let i of l) {
        if (i > elem) {
            array.splice(k, 0, elem);
            break;
        }
        k++;
    }
    return array;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([5, 4, 3, 2, 1, 0], 3),[3, 5, 4, 3, 2, 1, 0]);
}

test();
