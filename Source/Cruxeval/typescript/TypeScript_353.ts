function f(x: number[]): number {
    if (x.length === 0) {
        return -1;
    } else {
        let cache: {[key: number]: number} = {};
        x.forEach((item) => {
            if (cache[item]) {
                cache[item] += 1;
            } else {
                cache[item] = 1;
            }
        });
        return Math.max(...Object.values(cache));
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 0, 2, 2, 0, 0, 0, 1]),4);
}

test();
