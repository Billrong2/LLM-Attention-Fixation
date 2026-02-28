function f(list_x: number[]): number[] {
    const item_count: number = list_x.length;
    const new_list: number[] = [];
    for (let i = 0; i < item_count; i++) {
        new_list.push(list_x.pop()!);
    }
    return new_list;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([5, 8, 6, 8, 4]),[4, 8, 6, 8, 5]);
}

test();
