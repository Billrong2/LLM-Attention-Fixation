function f(array: number[], values: number[]): number[] {
    const newArray = array.slice(); // Create a copy of the original array
    newArray.reverse();
    values.forEach(value => {
        newArray.splice(newArray.length / 2, 0, value);
    });
    newArray.reverse();
    return newArray;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([58], [21, 92]),[58, 92, 21]);
}

test();
