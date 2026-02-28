function f(row: string): [number, number] {
    let count1 = 0, count0 = 0;
    for(let i = 0; i < row.length; i++) {
        if(row[i] === '1') {
            count1++;
        }
        if(row[i] === '0') {
            count0++;
        }
    }
    return [count1, count0];
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("100010010"),[3, 6]);
}

test();
