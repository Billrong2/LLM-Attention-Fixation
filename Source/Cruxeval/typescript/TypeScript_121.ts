function f(s: string): string {
    const nums: string = s.split('').filter(c => !isNaN(parseInt(c))).join('');
    if (nums === '') {
        return 'none';
    }
    const maxNum: number = Math.max(...nums.split(',').map(num => parseInt(num)));
    return maxNum.toString();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("01,001"),"1001");
}

test();
