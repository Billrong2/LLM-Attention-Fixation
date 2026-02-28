function f(nums: number[]): string {
    const count: number = nums.length;
    const score: { [key: number]: string } = {0: "F", 1: "E", 2: "D", 3: "C", 4: "B", 5: "A", 6: ""};
    const result: string[] = [];
    for (let i = 0; i < count; i++) {
        result.push(score[nums[i]]);
    }
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([4, 5]),"BA");
}

test();
