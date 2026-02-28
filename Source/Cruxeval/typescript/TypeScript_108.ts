function f(varInput: number | string | any[] | {[key: string]: any}): number {
    let amount: number = 0;
    if(Array.isArray(varInput)) {
        amount = varInput.length;
    } else if(typeof varInput === 'object' && varInput !== null) {
        amount = Object.keys(varInput).length;
    }
    let nonzero: number = amount > 0 ? amount : 0;
    return nonzero;
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(1),0);
}

test();
