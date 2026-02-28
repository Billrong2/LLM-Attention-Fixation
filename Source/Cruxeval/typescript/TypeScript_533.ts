function f(query: string, base: {[key: string]: number}): number {
    let net_sum: number = 0;
    for (let key of Object.keys(base)) {
        let val = base[key];
        if (key[0] === query && key.length === 3) {
            net_sum -= val;
        } else if (key[key.length - 1] === query && key.length === 3) {
            net_sum += val;
        }
    }
    return net_sum;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("a", {}),0);
}

test();
