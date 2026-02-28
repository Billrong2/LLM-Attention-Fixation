function f(selfie: number[]): number[] {
    let lo = selfie.length;
    for(let i = lo - 1; i >= 0; i--) {
        if (selfie[i] === selfie[0]) {
            selfie.pop();
        }
    }
    return selfie;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([4, 2, 5, 1, 3, 2, 6]),[4, 2, 5, 1, 3, 2]);
}

test();
