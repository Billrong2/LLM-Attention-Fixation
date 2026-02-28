function f(text1: string, text2: string): number {
    let nums: number[] = [];
    for (let i = 0; i < text2.length; i++) {
        nums.push(text1.split(text2[i]).length - 1);
    }
    return nums.reduce((acc, curr) => acc + curr, 0);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("jivespdcxc", "sx"),2);
}

test();
