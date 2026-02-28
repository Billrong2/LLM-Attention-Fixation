function f(items: [number, string][]): {[key: number]: number}[] {
    let result: {[key: number]: number}[] = [];
    for (let i = 0; i < items.length; i++) {
        let d: {[key: number]: number} = {};
        for(let j = 0; j < items.length - 1; j++) {
            d[items[j][0]] = items[j][0];
        }
        result.push(d);
        items = Object.entries(d).map(([key, value]) => [Number(key), String(value)]);
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([[1, "pos"]]),[{}]);
}

test();
