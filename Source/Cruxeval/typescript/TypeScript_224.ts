function f(array: string[], value: number): {[key: string]: number} {
    array.reverse();
    array.pop();
    const odd: {[key: string]: number}[] = [];
    while (array.length > 0) {
        const tmp: {[key: string]: number} = {};
        tmp[array.pop()] = value;
        odd.push(tmp);
    }
    const result: {[key: string]: number} = {};
    while (odd.length > 0) {
        const item = odd.pop();
        if (item) {
            for (const key in item) {
                if (item.hasOwnProperty(key)) {
                    result[key] = item[key];
                }
            }
        }
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["23"], 123),{});
}

test();
