function f(marks: {[key: string]: number}): [number, number] {
    let highest: number = 0;
    let lowest: number = 100;
    for (const value of Object.values(marks)) {
        if (value > highest) {
            highest = value;
        }
        if (value < lowest) {
            lowest = value;
        }
    }
    return [highest, lowest];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"x": 67, "v": 89, "": 4, "alij": 11, "kgfsd": 72, "yafby": 83}),[89, 4]);
}

test();
