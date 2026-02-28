function f(values: number[], item1: number, item2: number): number[] {
    if (values[values.length - 1] === item2) {
        if (!values.slice(1).includes(values[0])) {
            values.push(values[0]);
        }
    } else if (values[values.length - 1] === item1) {
        if (values[0] === item2) {
            values.push(values[0]);
        }
    }
    return values;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([1, 1], 2, 3),[1, 1]);
}

test();
