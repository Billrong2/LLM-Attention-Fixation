function f(base_list: number[], nums: number[]): number[] {
    base_list.push(...nums);
    let res: number[] = base_list.slice();
    for(let i = -nums.length; i < 0; i++){
        res.push(res[res.length + i]);
    }
    return res;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([9, 7, 5, 3, 1], [2, 4, 6, 8, 0]),[9, 7, 5, 3, 1, 2, 4, 6, 8, 0, 2, 6, 0, 6, 6]);
}

test();
