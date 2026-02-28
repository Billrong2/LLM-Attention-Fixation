function f(lst: number[]): number[] {
    let operation: (x: number[]) => void = (x: number[]) => x.reverse();
    let new_list = [...lst];
    new_list.sort();
    operation(new_list);
    return lst;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([6, 4, 2, 8, 15]),[6, 4, 2, 8, 15]);
}

test();
